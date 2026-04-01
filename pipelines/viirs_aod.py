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
from stac import bboxes

# A spatial resolution of 750 meters corresponds roughly to 0.0067 degrees when
# using the mean radius of the Earth.
SCALE_FACTOR = 0.006737353417

# Due to issues with raster projection at extreme latitudes, we only use pixels
# between -85 and 85 degrees latitude.
ALLOWED_EXTENT = bboxes.BBox(-180, -85, 180, 85)

# Fill values differ depending on what a raster represents.
FLAG_FILL = -128
INDEX_FILL = -1
DATA_FILL = -999.999

# VIIRS sensor channels M1-M11. AOD_channel and SfcRfl are 3D rasters that
# contain one 2D raster for each channel.
SENSOR_CHANNELS = tuple(f'M{i}' for i in range(1, 12))

# The four land aerosol models. The integer value of each in the AerMdl band
# is given by its 1-indexed position here, as 0 is used for oceanic aerosol.
# AOD550LndMdl and ResLndMdl are 3D rasters that contain one 2D raster for each
# model.
LAND_AEROSOL_MODELS = ('Dust', 'Generic', 'Urban', 'Smoke')

# All rasters are projected using GLTs derived from the pixels in QCAll, the
# overall flag for AOE retrieval. That raster is expected to have non-fill
# values are nearly all pixels.
QC_ALL = 'QCAll'


@dataclasses.dataclass(frozen=True)
class Raster:
  """Raster properties that are used to define bands.

  Properties:
    name: Name of the dataset in the .nc file.
    fill_value: int or float fill value.
    params: For 3D rasters, strings describing the parameter used to generate
      each of the 2D rasters.
  """

  name: str
  fill_value: Union[int, float]
  params: Sequence[str] = dataclasses.field(default_factory=list)


RASTERS = (
    Raster('AOD550', DATA_FILL),
    Raster('AOD_channel', DATA_FILL, SENSOR_CHANNELS),
    Raster('AngsExp1', DATA_FILL),
    Raster('AngsExp2', DATA_FILL),
    Raster('SfcRefl', DATA_FILL, SENSOR_CHANNELS),
    Raster('SpaStddev', DATA_FILL),
    Raster('Residual', DATA_FILL),
    Raster('AOD550LndMdl', DATA_FILL, LAND_AEROSOL_MODELS),
    Raster('ResLndMdl', DATA_FILL, LAND_AEROSOL_MODELS),
    Raster('FineMdlIdx', INDEX_FILL),
    Raster('CoarseMdlIdx', INDEX_FILL),
    Raster('FineModWgt', DATA_FILL),
    Raster('AerMdl', INDEX_FILL),
    Raster(QC_ALL, FLAG_FILL),
    Raster('QCAE', FLAG_FILL),
    Raster('QCExtn', FLAG_FILL),
    Raster('QCTest', FLAG_FILL),
    Raster('QCInput', FLAG_FILL),
    Raster('QCPath', FLAG_FILL),
    Raster('QCRet', FLAG_FILL),
)


def build_glts(
    source: h5py.File,
    num_threads: int = 10,
) -> list[geocorrect.GeoLookupTable]:
  """Return the GLT(s) needed to project the given VIIRS AOD data.

  A Geographic Lookup Table provides, for each index in the original 2D arrays,
  the mapping to the 2D array index in a north-up lat-lon grid. We use the
  pixels in the QC_ALL raster as the basis for the GLT(s) used to project all of
  the RASTERS in `source`. By using a mask, we ignore coordinates where QC_ALL
  has a fill value, allowing them to be filled with the nearest non-fill value
  neighbor located up to two pixels away.

  However, if a raster has a fill value at (i, j) and QC_ALL has a non-fill
  value at the same index, that fill value will be projected when the GLT is
  applied to the raster. For a cleaner visualization, users can interpolate or
  smooth the image in Earth Engine, e.g.:

    var raster = image.select(BAND_NAME)
    var raster_mean = raster.reduceNeighborhood({
      reducer: ee.Reducer.mean(),
      kernel: ee.Kernel.square({radius: 2, units: 'pixels'}),
      skipMasked: false
    });
    var final_raster_mean = raster.unmask(raster_mean);

  If the mask ends up discarding all coordinates from the input, we will not
  return any GLTs. It is up to the caller to decide if this should be considered
  an error.

  Args:
    source: h5py.File
    num_threads: Number of threads to use when generating each GLT

  Returns:
    A list of GeoLookupTables. There will only be one if the source crosses
    the antimeridian, so there will be one GLT for each hemisphere.
  """
  lat = source['Latitude']
  lon = source['Longitude']

  band = source[QC_ALL]
  band_arr = band[:]
  band_fill_value = band.fillvalue
  del band
  band_arr[band_arr != band_fill_value] = 1
  band_arr[band_arr == band_fill_value] = 0
  mask_arr = band_arr.astype(numpy.uint8)
  del band_arr

  try:
    return geocorrect.GeoLookupTable.from_index(
        geocorrect.CoordinateIndex.from_arrays(
            lat[:],
            lon[:],
            lat_fill_value=lat.fillvalue,
            lon_fill_value=lon.fillvalue,
            mask=mask_arr,
            allowed_extent=ALLOWED_EXTENT,
        ),
        scale_lat=-SCALE_FACTOR,
        scale_lon=SCALE_FACTOR,
        max_nn_distance=2,
        num_threads=num_threads,
    )
  except geocorrect.EmptyInputError:
    logging.warning('No GLTs built with %s as the mask', QC_ALL)
    return []
