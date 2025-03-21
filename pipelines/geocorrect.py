# Copyright 2025 The Google Earth Engine Community Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Module for projecting raw data into north-up lat-lon grids.

Some data are distributed in files that contain latitude and longitude rasters
alongside observations, where the coordinate of the observation at index [i, j]
is (latitude[i, j], longitude[i, j]). This module defines generic objects for
projecting the observation arrays into lat-lon grids that are defined by the
bounding box of the raw coordinates and a user-supplied scale factor.

An example usage for an h5py File may look like:

  def project(f: h5py.File) -> Iterator[str]:
    lat = f['Latitude']  # or whatever the Latitude dataset is named
    lon = f['Longitude']
    index = geocorrect.CoordinateIndex.from_arrays(
      lat, lon, lat.fillvalue, lon.fillvalue
    )
    for idx, glt in enumerate(
        geocorrect.GeoLookupTable.from_index(index, SCALE_LAT, SCALE_LON)
    ):
      for ds_name in MY_DATASETS:
        ds = f[ds_name]
        projected_arr = glt.apply_to(ds[:], ds.fillvalue, ds.dtype)
        outfile = generate_tif_path(ds_name, idx)
        write_tif_file(outfile, projected_arr, ...)
        yield outfile

This module was originally written in March 2025 to help ingest VIIRS Aerosol
Optical Depth and Aerosol Particle Size EDRs files into Earth Engine; see
../viirs_aod.py.
"""

import concurrent.futures
import dataclasses
import math
from typing import Optional, Self, Union

from absl import logging
import numpy
from sklearn import neighbors
from sklearn.metrics import pairwise

from stac import bboxes

# Fill value to use for the GLT arrays.
GLT_FILL_VALUE = -1


class Error(Exception):
  """Base Error for the geocorrect module."""


class InputError(Error):
  """Error raised when a method receives unexpected input."""


class EmptyInputError(InputError):
  """Error raised when we don't have any coordinates to project."""


class ProjectionError(Error):
  """Error raised when we fail to project a coordinate into lat-lon."""


@dataclasses.dataclass(frozen=True)
class S1Interval:
  """An S1Interval represents a closed interval on a unit circle.

  Properties:
    low: Minimum point in degrees.
    high: Maximum point in degrees. If high < low, then the interval is
      inverted. This can be used to detect antimeridian crossings when the
      input points are longitudes.
  """

  low: float
  high: float

  @classmethod
  def empty(cls) -> Self:
    """Returns an empty S1Interval."""
    return cls(180, -180)

  def is_empty(self) -> bool:
    """Returns True if the S1Interval is empty."""
    return self.low == 180 and self.high == -180

  def contains(self, longitude: float) -> bool:
    """Returns True if the given longitude is contained by the interval."""
    if self.low > self.high:
      return longitude >= self.low or longitude <= self.high
    else:
      return longitude >= self.low and longitude <= self.high

  @classmethod
  def positive_distance(cls, degrees_a: float, degrees_b: float) -> float:
    """Returns the distance between two points in the range [0, 360)."""
    diff = degrees_b - degrees_a
    if diff >= 0:
      return diff
    else:
      # If b is 180 and a is -180 + epsilon, we'd prefer to return 360.
      return (degrees_b + 180) - (degrees_a - 180)

  @classmethod
  def check(
      cls, degrees_low: float, degrees_high: float
  ) -> tuple[float, float]:
    """Returns points so that the low-high interval is on a unit circle."""
    if degrees_low == -180 and degrees_high != 180:
      degrees_low = math.pi
    if degrees_high == -180 and degrees_low != 180:
      degrees_high = math.pi
    return degrees_low, degrees_high

  def add_longitude(self, lon: float) -> Self:
    """Returns an S1Interval that includes `lon`."""
    if math.fabs(lon) > 180:
      raise InputError('Cannot add latitude %f to S1Interval'.format(lon))
    if lon == -180:
      lon = 180

    if self.is_empty():
      return S1Interval(lon, lon)
    elif self.contains(lon):
      return self
    else:
      dist_low = self.positive_distance(lon, self.low)
      dist_high = self.positive_distance(self.high, lon)
      if dist_low < dist_high:
        return S1Interval(*self.check(lon, self.high))
      else:
        return S1Interval(*self.check(self.low, lon))


@dataclasses.dataclass(frozen=True)
class CoordinateIndex:
  """An index of (lat, lon) coordinates to their array offsets in 2D rasters.

  Properties:
    points: A list of (latitude, longitude) pairs.
    point_index: A map from (latitude, longitude) to the (i, j) position in the
      original 2D rasters.
    bbox_list: The bounding boxes that cover all of `points`. Generally there
      will only be one, but there will be two if the region crosses the
      antimeridian, one for each side. Note that if 'points' represent pixel
      centers, then the bounding boxes will not cover the entire border.
  """

  points: list[tuple[float, float]]
  point_index: dict[tuple[float, float], tuple[int, int]]
  bbox_list: list[bboxes.BBox]

  @classmethod
  def from_arrays(
      cls,
      lat: numpy.ndarray,
      lon: numpy.ndarray,
      lat_fill_value: Union[int, float] = numpy.nan,
      lon_fill_value: Union[int, float] = numpy.nan,
      mask: Optional[numpy.ndarray] = None,
  ) -> Self:
    """Returns a GeoIndex for the given lat and lon rasters.

    Arguments:
      lat: Numpy array of latitude values.
      lon: Numpy array of longitude values. We expect that for a given (i, j),
        lat[i, j] and lon[i, j] give the real-world coordinate for a piece of
        data at a corresponding raster[i, j].
      lat_fill_value: The "no data" value for the latitude raster. These points
        are ignored when building the GLT and bounding box.
      lon_fill_value: The "no data" value for the longitude raster. These points
        are ignored when building the GLT and bounding box.
      mask: Numpy array with the same shape as `lat` and `lon`, where zero
        indicates that a point should be ignored when building the GLT (in
        addition to `lat_fill_value` and `lon_fill_value`). This does NOT affect
        the bounding box calculation.

    Returns:
      CoordinateIndex

    Raises:
      InputError: If the input rasters aren't the same shape.
      EmptyInputError: If the input rasters had no non-fill, non-masked points.
      InvariantError: If we fail to construct a valid pair of bounding boxes
        for a grid that crosses the antimeridian.
    """
    if lat.shape != lon.shape:
      raise InputError(
          'Latitude ({}) and longitude ({}) rasters have different '
          'shapes.'.format(lat.shape, lon.shape)
      )
    if mask is not None and lat.shape != mask.shape:
      raise InputError(
          'Latitude ({}) and mask ({}) rasters have different shapes.'.format(
              lat.shape, mask.shape
          )
      )
    logging.info('Source rasters have shape %s', lat.shape)

    # Build a bounding box in each hemisphere. This will matter if we cross the
    # antimeridian; we don't want a single box that spans from (-180, 180) with
    # a lot of empty pixels in the middle.
    west_bbox = None
    east_bbox = None
    s1_interval = S1Interval.empty()
    if mask is None:
      mask = numpy.full((lat.shape[0], lat.shape[1]), 1, dtype=numpy.uint8)

    points = []
    point_index = {}
    for i, (lat_col, lon_col, mask_col) in enumerate(zip(lat, lon, mask)):
      for j, (lat_ij, lon_ij, mask_ij) in enumerate(
          zip(lat_col, lon_col, mask_col)
      ):
        if (
            lat_ij == lat_fill_value
            or lon_ij == lon_fill_value
            # == doesn't work for numpy.nan
            or (numpy.isnan(lat_ij) and numpy.isnan(lat_fill_value))
            or (numpy.isnan(lon_ij) and numpy.isnan(lon_fill_value))
        ):
          continue
        lat_ij = lat_ij.item()
        lon_ij = lon_ij.item()
        if mask_ij != 0:
          points.append((lat_ij, lon_ij))
          point_index[(lat_ij, lon_ij)] = (i, j)
        s1_interval = s1_interval.add_longitude(lon_ij)

        # Update the appropriate bounding box depending on the hemisphere of
        # this point.
        if lon_ij <= 0:
          if west_bbox is None:
            west_bbox = bboxes.BBox(lon_ij, lat_ij, lon_ij, lat_ij)
          this_bbox = west_bbox
        else:
          if east_bbox is None:
            east_bbox = bboxes.BBox(lon_ij, lat_ij, lon_ij, lat_ij)
          this_bbox = east_bbox
        if lat_ij < this_bbox.south:
          this_bbox.south = lat_ij
        if lat_ij > this_bbox.north:
          this_bbox.north = lat_ij
        if lon_ij < this_bbox.west:
          this_bbox.west = lon_ij
        if lon_ij > this_bbox.east:
          this_bbox.east = lon_ij

    bbox_list = []
    if s1_interval.is_empty():
      raise EmptyInputError('The input grid was empty')
    elif s1_interval.low > s1_interval.high:
      # If the S1Interval is inverted, then we crossed the antimeridian.
      if east_bbox is None or west_bbox is None:
        raise ProjectionError(
            'The antimeridian was crossed but one hemisphere has a null bbox'
        )
      bbox_list.extend((east_bbox, west_bbox))
    else:
      if east_bbox is not None:
        if west_bbox is not None:
          # We crossed the prime meridian, which is fine.
          bbox_list.append(east_bbox.union(west_bbox))
        else:
          bbox_list.append(east_bbox)
      elif west_bbox is not None:
        bbox_list.append(west_bbox)
      else:
        raise EmptyInputError('The input grid was empty')

    if not points:
      raise EmptyInputError(
          'No points mapped by CoordinateIndex with bounding boxes: %s',
          bbox_list,
      )
    return cls(points, point_index, bbox_list)


@dataclasses.dataclass(frozen=True)
class GeoLookupTable:
  """A GeoLookupTable (GLT) maps raw lat/lon rasters onto a north-up grid.

  Consider a 2D raster that needs to be projected:

                ..***..
   ******       ******.
   ******  =>   .******
   ******       ..***..

  Assuming the raster has the same dimensions as rasters containing the raw
  latitude and longitude of each data point (typically, the source file contains
  separate lat and lon bands), we can determine the corresponding position in
  the projected grid.
  """

  _bbox: bboxes.BBox
  _scale_lat: float
  _scale_lon: float
  _glt: numpy.ndarray

  @classmethod
  def from_index(
      cls,
      index: CoordinateIndex,
      scale_lat: float,
      scale_lon: float,
      max_nn_distance: int = 1,
      num_threads: int = 1,
      buffer_bbox: bool = True,
  ) -> list[Self]:
    """Returns GeoLookupTables for the given CoordinateIndex.

    Arguments:
      index: The CoordinateIndex containing the lat/lon points.
      scale_lat: The scale, in degrees, of each pixel in the north-south
        direction. In a north-up grid, this should be a negative number.
      scale_lon: The scale, in degrees, of each pixel in the east-west
        direction. In a north-up grid, this should be a positive number.
      max_nn_distance: When interpolating pixels, the maximum number of pixels
        away the nearest neighbor may be. Any point that has no nearer neighbor
        will be unfilled.
      num_threads: The number of threads to use when building the GLT. If the
        number of pixels in the corrected grid is large (can be due to a number
        of factors: size of the bbox, the requested scale, both...), multiple
        threads may be needed to build the GLT in a reasonable amount of time.
      buffer_bbox: If True, assume that the corners of each bounding box are
        pixel centers, meaning the boxes must be extended based on `scale_lat`
        and `scale_lon` to account for the full pixel size.

    Returns:
      GeoLookupTables, one for each bounding box in `index`

    Raises:
      InputError: If scale factors are unexpected.
      ProjectionError: if there was an error mapping points into the grid.
    """
    if scale_lat >= 0 or scale_lon <= 0:
      raise InputError(
          'Expected negative scale_lat ({}) and positive scale_lon ({})'.format(
              scale_lat, scale_lon
          )
      )

    # When filling in the corrected grid, we pick a pixel by finding the nearest
    # original point to the given position. We fill any gaps by choosing the
    # nearest neighbor as long as it is not too many pixels away.
    tree = neighbors.BallTree(
        [(math.radians(x), math.radians(y)) for x, y in index.points],
        metric='haversine',
        leaf_size=10,
    )
    max_distance = max_nn_distance * max(
        pairwise.haversine_distances(
            [[0, 0], [math.radians(scale_lat), math.radians(scale_lon)]]
        )[0]
    )

    tables = []
    for bbox in index.bbox_list:
      if buffer_bbox:
        bbox = bboxes.BBox(
            west=max(-180, min(180, bbox.west - (scale_lon / 2))),
            south=max(-90, min(90, bbox.south + (scale_lat / 2))),
            east=max(-180, min(180, bbox.east + (scale_lon / 2))),
            north=max(-90, min(90, bbox.north - (scale_lat / 2))),
        )

      # Preallocate the GLTs so we only have to do assignment below.
      # This should speed things up when the size of the grid is large, which
      # tends to happen the farther you get from the equator.
      num_cols = int(math.ceil((bbox.south - bbox.north) / scale_lat))
      num_rows = int(math.ceil((bbox.east - bbox.west) / scale_lon))
      glt_i = [[GLT_FILL_VALUE] * num_rows for _ in range(0, num_cols)]
      glt_j = [[GLT_FILL_VALUE] * num_rows for _ in range(0, num_cols)]
      logging.info('GLT will have shape (%d, %d)', num_cols, num_rows)

      # Further speed things up by working in parallel.
      # The "cell-var-from-loop" warnings can be ignored because those vars
      # are global from this method's point of view.
      # pylint: disable=cell-var-from-loop
      def _fill_glt_col(col_idx: int) -> None:
        """Populates `glt_i` and 'glt_j` for a single column."""
        lat = bbox.north + (col_idx * scale_lat) + (scale_lat / 2)
        lons = [
            bbox.west + (row_idx * scale_lon) + (scale_lon / 2)
            for row_idx in range(0, num_rows)
        ]

        dd, ii = tree.query(
            [(math.radians(lat), math.radians(lon)) for lon in lons], k=1
        )
        for row_idx, (near_dist, near_idx) in enumerate(zip(dd, ii)):
          if near_dist[0] > max_distance:
            continue
          elif near_idx[0] >= len(index.points):
            raise ProjectionError('Bad nearest index {}'.format(near_idx[0]))
          else:
            orig_point = index.points[near_idx[0]]
            orig_ij = index.point_index.get(orig_point)
            if orig_ij is None:
              raise ProjectionError('Bad nearest point {}'.format(orig_point))
            glt_i[col_idx][row_idx] = orig_ij[0]
            glt_j[col_idx][row_idx] = orig_ij[1]

      # pylint: enable=cell-var-from-loop

      with concurrent.futures.ThreadPoolExecutor(
          max_workers=num_threads
      ) as executor:
        for col_idx in range(0, num_cols):
          executor.submit(_fill_glt_col, col_idx)

      glt = numpy.stack((glt_i, glt_j), axis=-1, dtype=numpy.int64)
      tables.append(cls(bbox, scale_lat, scale_lon, glt))

    return tables

  def apply_to(
      self,
      raster: numpy.ndarray,
      fill_value: Union[int, float],
      dtype: type[numpy.number],
  ) -> numpy.ndarray:
    """Returns a new numpy array with the GLT applied to the input raster.

    Args:
      raster: The original raster as a numpy array. This should NOT be an HDF5
        dataset, which has tighter restrictions on fancy indexing. If so, be
        sure to convert before passing it in (e.g., dataset[band_name][:]).
      fill_value: The "no data" value for the raster.
      dtype: The numpy type of the raster values.

    Returns:
      numpy array
    """
    new_raster = numpy.full(
        (self._glt.shape[0], self._glt.shape[1]), fill_value, dtype=dtype
    )
    valid_glt = numpy.all(self._glt != GLT_FILL_VALUE, axis=-1)
    new_raster[valid_glt] = raster[
        self._glt[valid_glt, 0], self._glt[valid_glt, 1]
    ]
    return new_raster

  def geotransform(self) -> list[float]:
    """Returns the geotransform for this bounding box in gdal order."""
    return [
        self._bbox.west,  # translationX
        self._scale_lon,  # scaleX
        0,
        self._bbox.north,  # translationY
        0,
        self._scale_lat,  # scaleY
    ]
