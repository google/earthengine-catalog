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

"""Module for projecting raw data rasters into north-up WGS84."""

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
GLT_FILLVALUE = -1


class Error(Exception):
  """Base Error for the geocorrect module."""


class InputError(Error):
  """Error raised when a method receives unexpected input."""


class ProjectionError(Error):
  """Error raised when we fail to project a coordinate into WGS84."""


@dataclasses.dataclass(frozen=True)
class CoordinateIndex:
  """An index of (lat, lon) coordinates to their array offsets in 2D rasters.

  Properties:
    points: A list of (latitude, longitude) pairs.
    point_index: A map from (latitude, longitude) to the (i, j) position in the
      original 2D rasters.
    bbox_list: The bounding boxes that cover all of `points`. Generally there
      will only be one, but there will be two if the region crosses the
      anti-meridian, one for each side. Note that if 'points' represent pixel
      centers, then the bounding boxes will not cover the entire border.
  """

  points: list[tuple[float, float]]
  point_index: dict[tuple[float, float], tuple[int, int]]
  bbox_list: list[bboxes.BBox]

  @classmethod
  def _is_west_to_east(
      cls, lon: numpy.ndarray, lon_fillvalue: Union[int, float] = numpy.nan
  ) -> bool:
    """Returns True if longitudes increase when iterating across the array."""
    # We rarely have to do much looping since we only need two adjacent points
    # to compare. The loop provides some guardrails for the unexpected case
    # where `lon` is extremely sparse.
    for lon_col in lon:
      lon_prev = None
      for lon_ij in lon_col:
        if lon_ij == lon_fillvalue or (
            # == doesn't work for numpy.nan
            numpy.isnan(lon_ij)
            and numpy.isnan(lon_fillvalue)
        ):
          continue
        elif lon_prev is None:
          lon_prev = lon_ij
        elif math.copysign(1, lon_ij) == math.copysign(1, lon_prev):
          # Only do the comparison for adjacent points between the same
          # meridians. While this comparison works when crossing the prime, it
          # breaks if crossing the anti.
          return lon_ij > lon_prev
        else:
          lon_prev = lon_ij
    raise InputError('Unable to determine direction of longitude raster.')

  @classmethod
  def from_arrays(
      cls,
      lat: numpy.ndarray,
      lon: numpy.ndarray,
      lat_fillvalue: Union[int, float] = numpy.nan,
      lon_fillvalue: Union[int, float] = numpy.nan,
      mask: Optional[numpy.ndarray] = None,
  ) -> Self:
    """Returns a GeoIndex for the given lat and lon rasters.

    Arguments:
      lat: Numpy array of latitude values.
      lon: Numpy array of longitude values. We expect that for a given (i, j),
        lat[i, j] and lon[i, j] give the real-world coordinate for a piece of
        data at a corresponding raster[i, j].
      lat_fillvalue: The "no data" value for the latitude raster. These points
        are ignored when building the GLT and bounding box.
      lon_fillvalue: The "no data" value for the longitude raster. These points
        are ignored when building the GLT and bounding box.
      mask: Numpy array of with the same shape a `lat` and `lon`, where zero
        indicates that a point should be ignored when building the GLT (in
        addition to `lat_fillvalue` and `lon_fillvalue`). This does NOT affect
        the bounding box calculation.

    Returns:
      CoordinateIndex

    Raises:
      InputError: If the input rasters aren't the same shape or had no valid
        points, resulting in no bounding boxes.
      InvariantError: If we fail to construct a valid pair of bounding boxes
        for a grid that crosses the anti-meridian.
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
    # anti-meridian; we don't want a single box that spans from (-180, 180) with
    # a lot of empty pixels in the middle.
    west_to_east = cls._is_west_to_east(lon, lon_fillvalue)
    west_bbox = None
    east_bbox = None
    crosses_antimeridian = False
    if mask is None:
      mask = numpy.full((lat.shape[0], lat.shape[1]), 1, dtype=numpy.uint8)

    points = []
    point_index = {}
    for i, (lat_col, lon_col, mask_col) in enumerate(zip(lat, lon, mask)):
      lon_prev = None
      for j, (lat_ij, lon_ij, mask_ij) in enumerate(
          zip(lat_col, lon_col, mask_col)
      ):
        if (
            lat_ij == lat_fillvalue
            or lon_ij == lon_fillvalue
            # == doesn't work for numpy.nan
            or (numpy.isnan(lat_ij) and numpy.isnan(lat_fillvalue))
            or (numpy.isnan(lon_ij) and numpy.isnan(lon_fillvalue))
        ):
          continue
        lat_ij = lat_ij.item()
        lon_ij = lon_ij.item()
        if mask_ij != 0:
          points.append((lat_ij, lon_ij))
          point_index[(lat_ij, lon_ij)] = (i, j)

        # Detect an anti-meridian crossing. The triggering sign change depends
        # on the direction of the longitude raster.
        if lon_prev is not None and (
            (west_to_east and lon_ij < 0 and lon_prev > 0)
            or (not west_to_east and lon_ij > 0 and lon_prev < 0)
        ):
          crosses_antimeridian = True
        lon_prev = lon_ij

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
    if crosses_antimeridian:
      if east_bbox is None or west_bbox is None:
        raise ProjectionError(
            'The anti-meridian was crossed but one hemisphere has a null bbox'
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
        raise InputError('The input grid was empty')

    return cls(points, point_index, bbox_list)


@dataclasses.dataclass(frozen=True)
class GeoLookupTable:
  """A GeoLookupTable (GLT) maps raw lat/lon rasters onto a north-up WGS84 grid.

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
        direction. This will generally be a negative number.
      scale_lon: The scale, in degrees, of each pixel in the east-west
        direction. This will generally be a positive number.
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
    """
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
            west=bbox.west - (scale_lon / 2),
            south=bbox.south + (scale_lat / 2),
            east=bbox.east + (scale_lon / 2),
            north=bbox.north - (scale_lat / 2),
        )

      # Preallocate the GLTs so we only have to do assignment below.
      # This should speed things up when the size of the grid is large, which
      # tends to happen the farther you get from the equator.
      num_cols = int(math.ceil((bbox.south - bbox.north) / scale_lat))
      num_rows = int(math.ceil((bbox.east - bbox.west) / scale_lon))
      glt_i = [[GLT_FILLVALUE] * num_rows for _ in range(0, num_cols)]
      glt_j = [[GLT_FILLVALUE] * num_rows for _ in range(0, num_cols)]
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
      fillvalue: Union[int, float],
      dtype: type[numpy.number],
  ) -> numpy.ndarray:
    """Returns a new numpy array with the GLT applied to the input raster.

    Args:
      raster: The original raster as a numpy array. This should NOT be an HDF5
        dataset, which has tighter restrictions on fancy indexing. If so, be
        sure to convert before passing it in (e.g., dataset[band_name][:]).
      fillvalue: The "no data" value for the raster.
      dtype: The numpy type of the raster values.

    Returns:
      numpy array
    """
    new_raster = numpy.full(
        (self._glt.shape[0], self._glt.shape[1]), fillvalue, dtype=dtype
    )
    valid_glt = numpy.all(self._glt != GLT_FILLVALUE, axis=-1)
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
