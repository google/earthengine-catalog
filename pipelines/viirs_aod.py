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

"""Module for producing geocorrected rasters for VIIRS AOD files.

The VIIRS Aerosol Optical Depth and Aerosol Particle Size EDRs product is
distributed as files containing raw coordinates and observations at a spatial
resolution of 750 meters. To ingest these into Earth Engine, we project each
raster into a north-up lat-lon grid.

For more details, see the theoretical basis document at
https://www.star.nesdis.noaa.gov/jpss/documents/ATBD/ATBD_EPS_Aerosol_AOD_v3.4.pdf.
"""

from collections.abc import Sequence
import dataclasses
from typing import Union

from absl import logging
import h5py
import numpy

from google3.third_party.earthengine_catalog.pipelines import geocorrect

# A spatial resolution of 750 meters corresponds roughly to 0.0067 degrees when
# using the mean radius of the Earth.
SCALE_FACTOR = 0.006737353417

# Fill values differ depending on what a raster represents.
FLAG_FILL = -128
INDEX_FILL = -1
DATA_FILL = -999.999

# VIIRS sensor channels M1-M11. AOD_channel and SfcRfl are 3D rasters that
# contain one 2D raster for each channel.
SENSOR_CHANNELS = [f'M{i}' for i in range(1, 12)]

# The four land aerosol models. The integer value of each in the AerMdl band
# is given by its 1-indexed position here, as 0 is used for oceanic aerosol.
# AOD550LndMdl and ResLndMdl are 3D rasters that contain one 2D raster for each
# model.
LAND_AEROSOL_MODELS = ('Dust', 'Generic', 'Urban', 'Smoke')

# All quality flag rasters are projected using QCAll, the overall flag for AOE
# retrieval. These rasters are expected to have non-fill values are nearly all
# pixels.
QC_ALL = 'QCAll'

# Most of the rasters are projected using AOD550 as the mask. Generally, these
# rasters will only have a non-fill value at a coordinate where AOD550 could be
# successfully retrieved. SpaStddev is an exception -- thresholds are applied to
# it as part of "is aerosol present" checks by the model and therefore may have
# values where AOD is not successfully retrieved.
AOD_550 = 'AOD550'
SPA_STDDEV = 'SpaStddev'


@dataclasses.dataclass(frozen=True)
class Raster:
  """Raster properties that are used to define bands.

  Properties:
    name: Name of the dataset in the .nc file.
    fill_value: int or float fill value.
    mask_name: Name of the dataset in the .nc file to use as a mask when
      generating the GLT used to project this one. See `build_glts` below.
    params: For 3D rasters, strings describing the parameter used to generate
      each of the 2D rasters.
  """

  name: str
  fill_value: Union[int, float]
  mask_name: str
  params: Sequence[str] = dataclasses.field(default_factory=list)


RASTERS = (
    Raster(AOD_550, DATA_FILL, AOD_550),
    Raster('AOD_channel', DATA_FILL, AOD_550, SENSOR_CHANNELS),
    Raster('AngsExp1', DATA_FILL, AOD_550),
    Raster('AngsExp2', DATA_FILL, AOD_550),
    Raster('SfcRefl', DATA_FILL, AOD_550, SENSOR_CHANNELS),
    Raster(SPA_STDDEV, DATA_FILL, SPA_STDDEV),
    Raster('Residual', DATA_FILL, AOD_550),
    Raster('AOD550LndMdl', DATA_FILL, AOD_550, LAND_AEROSOL_MODELS),
    Raster('ResLndMdl', DATA_FILL, AOD_550, LAND_AEROSOL_MODELS),
    Raster('FineMdlIdx', INDEX_FILL, AOD_550),
    Raster('CoarseMdlIdx', INDEX_FILL, AOD_550),
    Raster('FineModWgt', DATA_FILL, AOD_550),
    Raster('AerMdl', INDEX_FILL, AOD_550),
    Raster(QC_ALL, FLAG_FILL, QC_ALL),
    Raster('QCAE', FLAG_FILL, QC_ALL),
    Raster('QCExtn', FLAG_FILL, QC_ALL),
    Raster('QCTest', FLAG_FILL, QC_ALL),
    Raster('QCInput', FLAG_FILL, QC_ALL),
    Raster('QCPath', FLAG_FILL, QC_ALL),
    Raster('QCRet', FLAG_FILL, QC_ALL),
)


def build_glts(
    source: h5py.File,
    num_threads: int = 10,
) -> dict[str, list[geocorrect.GeoLookupTable]]:
  """Return the GLT(s) needed to project the given VIIRS AOD data.

  A Geographic Lookup Table provides, for each index in the original 2D arrays,
  the mapping to the 2D array index in a north-up lat-lon grid. For the three
  mask rasters QC_ALL, AOD_550, and SPA_STDDEV, we build and return the GLTs
  needed to project all of the RASTERS in `source`. By using a mask, we ignore
  coordinates where the mask raster has a fill value, allowing them to be filled
  with the nearest non-fill value neighbor located up to two pixels away.

  If the mask ends up discarding all coordinates from the input, we will not
  return any GLTs for that name. It is up to the caller to decide if this
  should be considered an error.

  Args:
    source: h5py.File
    num_threads: Number of threads to use when generating each GLT

  Returns:
    A dict from mask name to a list of GeoLookupTables
  """
  lat = source['Latitude']
  lon = source['Longitude']

  glts = {}
  for mask_name in (QC_ALL, AOD_550, SPA_STDDEV):
    band = source[mask_name]
    band_arr = band[:]
    band_fill_value = band.fillvalue
    del band
    band_arr[band_arr != band_fill_value] = 1
    band_arr[band_arr == band_fill_value] = 0
    mask_arr = band_arr.astype(numpy.uint8)
    del band_arr

    try:
      glts[mask_name] = geocorrect.GeoLookupTable.from_index(
          geocorrect.CoordinateIndex.from_arrays(
              lat,
              lon,
              lat_fill_value=lat.fillvalue,
              lon_fill_value=lon.fillvalue,
              mask=mask_arr,
          ),
          scale_lat=-SCALE_FACTOR,
          scale_lon=SCALE_FACTOR,
          max_nn_distance=2,
          num_threads=num_threads,
      )
    except geocorrect.EmptyInputError:
      logging.warning('No GLTs built with %s as the mask', mask_name)

  return glts
