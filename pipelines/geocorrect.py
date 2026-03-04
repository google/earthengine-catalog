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
from scipy import spatial
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


def latlon_to_xyz(
    lat_deg: Union[float, numpy.ndarray], lon_deg: Union[float, numpy.ndarray]
) -> numpy.ndarray:
  """Converts lat/lon in degrees to Cartesian (x, y, z) on unit sphere."""
  lat = numpy.radians(lat_deg)
  lon = numpy.radians(lon_deg)
  x = numpy.cos(lat) * numpy.cos(lon)
  y = numpy.cos(lat) * numpy.sin(lon)
  z = numpy.sin(lat)
  return numpy.stack((x, y, z), axis=-1)


@dataclasses.dataclass(frozen=True)
class CoordinateIndex:
  """An index of (lat, lon) coordinates to their array offsets in 2D rasters.

  Properties:
    points: A numpy array of (lat, lon) points found in the source rasters.
    bbox_list: The bounding boxes that cover all relevant coordinate points.
    source_indices: A numpy array of (i, j) offsets into the original rasters.
  """

  points: numpy.ndarray
  bbox_list: list[bboxes.BBox]
  source_indices: numpy.ndarray

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

    # Coords that are not fill values are used for BBox calculation.
    coords_valid = (lat != lat_fill_value) & (lon != lon_fill_value)
    if numpy.isnan(lat_fill_value):
      coords_valid &= ~numpy.isnan(lat)
    if numpy.isnan(lon_fill_value):
      coords_valid &= ~numpy.isnan(lon)

    if not numpy.any(coords_valid):
      raise EmptyInputError('The input grid was empty')

    valid_lat = lat[coords_valid]
    valid_lon = lon[coords_valid]

    # Minimal enclosing interval on S1 to detect antimeridian crossing.
    lons_to_check = valid_lon.copy()
    lons_to_check[lons_to_check == -180] = 180
    lons_unique = numpy.unique(lons_to_check)
    if lons_unique.size == 1:
      s1_low, s1_high = float(lons_unique[0]), float(lons_unique[0])
    else:
      gaps = numpy.diff(lons_unique)
      wrap_gap = 360.0 - (lons_unique[-1] - lons_unique[0])
      max_gap_idx = numpy.argmax(gaps)
      if wrap_gap >= gaps[max_gap_idx]:
        s1_low, s1_high = float(lons_unique[0]), float(lons_unique[-1])
      else:
        s1_low, s1_high = (
            float(lons_unique[max_gap_idx + 1]),
            float(lons_unique[max_gap_idx]),
        )

    # Points for GLT are also filtered by `mask`.
    glt_valid = coords_valid.copy()
    if mask is not None:
      glt_valid = glt_valid & (mask != 0)

    if not numpy.any(glt_valid):
      raise EmptyInputError('The input grid had no unmasked points')

    idx_i, idx_j = numpy.where(glt_valid)
    points = numpy.stack([lat[glt_valid], lon[glt_valid]], axis=-1)
    source_indices = numpy.stack([idx_i, idx_j], axis=-1)

    # Build a bounding box in each hemisphere.
    is_west = valid_lon <= 0
    is_east = ~is_west

    bbox_list = []
    if numpy.any(is_west):
      w_lats = valid_lat[is_west]
      w_lons = valid_lon[is_west]
      bbox_list.append(
          bboxes.BBox(w_lons.min(), w_lats.min(), w_lons.max(), w_lats.max())
      )

    if numpy.any(is_east):
      e_lats = valid_lat[is_east]
      e_lons = valid_lon[is_east]
      bbox_list.insert(
          0, bboxes.BBox(e_lons.min(), e_lats.min(), e_lons.max(), e_lats.max())
      )

    if s1_low <= s1_high:
      # If we didn't cross the antimeridian, union the boxes. In this case, we
      # crossed the prime meridian, but that's fine.
      if len(bbox_list) == 2:
        bbox_list = [bbox_list[0].union(bbox_list[1])]

    return cls(points, bbox_list, source_indices)


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
    # nearest neighbor as long as it is not too many pixels away. We use the
    # Euclidean distance because it's faster than Haversine and roughly
    # equivalent.
    source_xyz = latlon_to_xyz(index.points[:, 0], index.points[:, 1])
    tree = spatial.cKDTree(source_xyz, leafsize=10)

    # Convert the angular max distance to chord distance.
    max_theta = max_nn_distance * max(
        pairwise.haversine_distances(
            [[0, 0], [math.radians(scale_lat), math.radians(scale_lon)]]
        )[0]
    )
    max_chord = 2 * math.sin(max_theta / 2)

    tables = []
    for bbox in index.bbox_list:
      if buffer_bbox:
        bbox = bboxes.BBox(
            west=max(-180, min(180, bbox.west - (scale_lon / 2))),
            south=max(-90, min(90, bbox.south + (scale_lat / 2))),
            east=max(-180, min(180, bbox.east + (scale_lon / 2))),
            north=max(-90, min(90, bbox.north - (scale_lat / 2))),
        )

      # Preallocate the GLT as a single numpy array.
      num_cols = int(math.ceil((bbox.south - bbox.north) / scale_lat))
      num_rows = int(math.ceil((bbox.east - bbox.west) / scale_lon))
      glt_full = numpy.full(
          (num_cols, num_rows, 2), GLT_FILL_VALUE, dtype=numpy.int64
      )
      logging.info('GLT will have shape (%d, %d)', num_cols, num_rows)

      # Generate all latitude centers and longitude centers.
      lats = bbox.north + numpy.arange(num_cols) * scale_lat + (scale_lat / 2)
      lons = bbox.west + numpy.arange(num_rows) * scale_lon + (scale_lon / 2)

      # Define a block size for batch processing.
      block_size = 100

      def _fill_glt_block(col_start: int) -> None:
        """Populates a block of columns in `glt_full`."""
        col_end = min(col_start + block_size, num_cols)
        block_lats = lats[col_start:col_end]

        # Use NumPy broadcasting to efficiently compute a 2D grid of XYZ
        # coordinates. By multiplying a column vector of (N_lats, 1) latitudes
        # with a row vector of (1, N_lons) longitudes, NumPy automatically
        # "broadcasts" the values to fill an (N_lats, N_lons) grid, which
        # avoids explicit loops and the memory overhead of calling meshgrid.
        rad_lat = numpy.radians(block_lats)
        rad_lon = numpy.radians(lons)
        cos_lat = numpy.cos(rad_lat)
        sin_lat = numpy.sin(rad_lat)
        cos_lon = numpy.cos(rad_lon)
        sin_lon = numpy.sin(rad_lon)

        # Broadcasting to create (N_lats, N_lons, 3) XYZ grid.
        x = cos_lat[:, numpy.newaxis] * cos_lon[numpy.newaxis, :]
        y = cos_lat[:, numpy.newaxis] * sin_lon[numpy.newaxis, :]
        z = numpy.repeat(sin_lat[:, numpy.newaxis], len(lons), axis=1)
        query_xyz = numpy.stack([x, y, z], axis=-1).reshape(-1, 3)

        # Use distance_upper_bound to prune search for points far from any data.
        dd, ii = tree.query(query_xyz, k=1, distance_upper_bound=max_chord)

        # Flattened block view for assignment.
        flat_ii = ii.flatten()
        flat_dd = dd.flatten()
        valid = flat_dd <= max_chord

        # Use NumPy's advanced ("fancy") indexing to bulk-fetch the original
        # (i, j) offsets for all points that were found within the max chord
        # distance.
        block_indices = numpy.full(
            (len(flat_ii), 2), GLT_FILL_VALUE, dtype=numpy.int64
        )
        block_indices[valid] = index.source_indices[flat_ii[valid]]

        glt_full[col_start:col_end, :, :] = block_indices.reshape(
            (col_end - col_start, num_rows, 2)
        )

      with concurrent.futures.ThreadPoolExecutor(
          max_workers=num_threads
      ) as executor:
        for col_start in range(0, num_cols, block_size):
          executor.submit(_fill_glt_block, col_start)

      tables.append(cls(bbox, scale_lat, scale_lon, glt_full))

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
