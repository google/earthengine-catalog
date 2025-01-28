# Copyright 2022 The Google Earth Engine Community Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This python code opens a single SMAP L3 HDF file and outputs a Geotiff in
# geographic projection
#
# requires pyl4c toolbox https://pypi.org/project/pyl4c/
#
# the output bands are as follows:
# 1) soil_moisture AM
# 2) tb_h_corrected AM
# 3) tb_v_corrected AM
# 4) vegetation_water_content AM
# 5) soil_moisture quality flag AM
# 6) tb_h_corrected quality flag AM
# 7) tb_v_corrected quality flag AM
# 8) soil_moisture PM
# 9) tb_h_corrected PM
# 10) tb_v_corrected PM
# 11) vegetation_water_content PM
# 12) soil_moisture quality flag PM
# 13) tb_h_corrected quality flag PM
# 14) tb_v_corrected quality flag PM
#
# where AM is 6:00 AM overpass and PM is 6:00 PM overpass
# quality flag of 0=good quality and flag=1 is bad quality
#
# Convert_SMAPL3_QA_EASEvsHDF5_GeoTiff_9km_AMPM.py
# written by Qing Liu, Arthur Endsley and Karyn Tabor
# last edited November 30, 2022 by Karyn Tabor

import copy
import glob
import os
import re

from absl import app
import numpy as np
from osgeo import gdal
from pyl4c.data.fixtures import EASE2_GRID_PARAMS
from pyl4c.epsg import EPSG
from pyl4c.lib.modis import dec2bin_unpack
from pyl4c.spatial import array_to_raster

from google3.third_party.earthengine_catalog.pipelines import smap_lib


# For the L3 data, the var list is very specific; the order matters
# for retrieving specific datasets
# 1:4 are data sets; 4 is SM QC; 5:6 is TB QC
VAR_LIST = [
    'soil_moisture', 'tb_h_corrected', 'tb_v_corrected',
    'vegetation_water_content', 'retrieval_qual_flag', 'tb_qual_flag_h',
    'tb_qual_flag_v'
]

# Nodata value to use in uint8 QC bands. The raw values of these bands may
# differ (e.g., uint16), so when that happens we change the nodata value to one
# that will fit in a byte.
QC_NODATA = 255


def SMAP_retrievalQC_pass_fail(raw_qc, raw_nodata):
  """Returns pass/fail for QC flags.

    Checks are based on the SMAP L3 QC protocol for the `retrieval_qual_flag`
    band: Bad pixels have either `1` in the first bit (Soil moisture retrieval
    doesn't have recommended quality) or in the third bit (Soil moisture
    retrieval was not successful).

    Output array is True wherever the array fails QC criteria or has no data.

    Parameters
    ----------
    raw_qc : numpy.ndarray : The raw QC flags taken from the source file.
        Values will be cast to uint8 before checking individual bits.
    raw_nodata : int or float : The numeric nodata value for `raw_qc`. We will
        change the values to QC_NODATA before casting to uint8.

    Returns
    -------
    numpy.ndarray : Boolean array with True wherever QC criteria are failed.
  """
  # We need to change nodata values from the original array so they'll fit in a
  # uint8. We don't simply check for qc > QC_NODATA because then we would
  # incorrectly allow undefined bits to contribute to the QC value.
  qc = np.array(raw_qc)
  qc[qc == raw_nodata] = QC_NODATA
  bits = dec2bin_unpack(qc.astype(np.uint8))
  # Emit 1 = FAIL if 1st bit == 1
  # ("Soil moisture retrieval doesn't have recommended quality")
  check1 = bits[...,7]
  # Third bit is ==1 "Soil moisture retrieval was not successful"
  check2 = bits[...,5]
  # Intermediate arrays are 1 = FAIL, 0 = PASS
  return (check1 + check2) > 0


def SMAP_TB_QC_pass_fail(raw_qc, raw_nodata):
  """Returns pass/fail for QC flags.

  Checks are based on the SMAP L3 QC protocol for the `tb_qual_flag_v` and
  `tb_qual_flag_h` layers: Bad pixels have a `1` in the first bit ("Observation
  does not have acceptable quality").

  Output array is True wherever the array fails QC criteria or has no data.

  Parameters
  ----------
    raw_qc : numpy.ndarray : The raw QC flags taken from the source file.
        Values will be cast to uint8 before checking individual bits.
    raw_nodata : int or float : The numeric nodata value for `raw_qc`. We will
        change the values to QC_NODATA before casting to uint8.

  Returns
    -------
    numpy.ndarray : Boolean array with True wherever QC criteria are failed.
  """
  # We need to change nodata values from the original array so they'll fit in a
  # uint8. We don't simply check for qc > QC_NODATA because then we would
  # incorrectly allow undefined bits to contribute to the QC value.
  qc = np.array(raw_qc)
  qc[qc == raw_nodata] = QC_NODATA
  bits = dec2bin_unpack(qc.astype(np.uint8))
  # Emit 1 = FAIL if 1st bit == 1 ("Data has acceptable quality")
  check1 = bits[...,7]
  # Intermediate arrays are 1 = FAIL, 0 = PASS
  return check1 > 0


def convert(source_h5, target_tif):
  """Converts a SMAP L3 HDF file to a geotiff."""

  # Options for gdal_translate
  translate_options = gdal.TranslateOptions(
      format='GTiff',
      outputSRS='+proj=cea +lon_0=0 +lat_ts=30 +ellps=WGS84 +units=m',
      outputBounds=[-17367530.45, 7314540.11, 17367530.45, -7314540.11],
  )

  # Base options for gdal.Warp. The destination nodata value will change for
  # each band.
  creation_options = ['COMPRESS=LZW']
  warp_options_kwargs = {
      'creationOptions': creation_options,
      'srcSRS': 'EPSG:6933',
      'dstSRS': 'EPSG:4326',
      'xRes': 0.08,
      'yRes': 0.08,
  }

  # array_to_raster params
  gt = EASE2_GRID_PARAMS['M09']['geotransform']
  wkt = EPSG[6933]
  translated_tif_list = []
  warped_tif_list = []

  for smap_opass in ('AM', 'PM'):
    pass_var_list = [
        s + ('_pm' if smap_opass == 'PM' else '') for s in VAR_LIST
    ]

    # Convert individual variables to separate GeoTiff files
    for band_index, var in enumerate(pass_var_list):
      sds = smap_lib.gdal_safe_open(
          f'HDF5:{source_h5}://Soil_Moisture_Retrieval_Data_{smap_opass}/{var}'
      )
      sds_band = sds.GetRasterBand(1)
      sds_array = sds_band.ReadAsArray()
      nodata_value = sds_band.GetNoDataValue()

      if band_index < 4:
        # The first four bands are soil moisture observations.
        sds_gdal = array_to_raster(sds_array, gt, wkt, nodata=nodata_value)
      else:
        # The last three are QC bands.
        qa = sds_array
        if band_index == 4:
          qa = SMAP_retrievalQC_pass_fail(sds_array, nodata_value)
        else:
          qa = SMAP_TB_QC_pass_fail(sds_array, nodata_value)
        # We get back boolean arrays that we cast to uint8. We must override the
        # default nodata value or this method will incorrectly clamp it to 0.
        sds_gdal = array_to_raster(
            qa, gt, wkt, dtype=np.uint8, nodata=QC_NODATA
        )
        nodata_value = QC_NODATA

      translated_tmp = f'/tmp/tmp_translated{len(translated_tif_list)}.tif'
      ds = gdal.Translate(translated_tmp, sds_gdal, options=translate_options)
      ds = None
      translated_tif_list.append(translated_tmp)

      warped_tmp = f'/tmp/tmp_warped{len(warped_tif_list)}.tif'
      this_warp_options_kwargs = copy.deepcopy(warp_options_kwargs)
      this_warp_options_kwargs['dstNodata'] = nodata_value
      ds = gdal.Warp(
          warped_tmp,
          translated_tmp,
          options=gdal.WarpOptions(**this_warp_options_kwargs),
      )
      ds = None
      warped_tif_list.append(warped_tmp)

  # Build a VRT (Virtual Dataset) that includes the list of input tif files and
  # use that to produce a single tif. It is safe to ignore the warning: "Unable
  # to export GeoTIFF file with different datatypes per different bands. All
  # bands should have the same types in TIFF." It actually exports just fine.
  # TODO(simonf): Remove this step and instead return the individual tifs.
  tmp_vrt = '/tmp/tmp.vrt'
  gdal.BuildVRT(tmp_vrt, warped_tif_list, options='-separate')
  ds = gdal.Translate(
      target_tif,
      tmp_vrt,
      options=gdal.TranslateOptions(creationOptions=['COMPRESS=LZW']),
  )
  ds = None

  # remove temporary files
  for f in [tmp_vrt] + translated_tif_list + warped_tif_list:
    if os.path.exists(f):
      os.remove(f)


def main(argv):
  convert(argv[1], argv[2])


if __name__ == '__main__':
  app.run(main)
