#!/usr/bin/python3
"""This is a script for an ad hoc comparison of NASA and EE data.

TODO(simonf): rename to compare_nasa_ee.py after AGU

The script compares data from NASA read via OpenDAP
and their replicas in Google Earth Engine.

Prerequsites:
* Earth Engine client
* xee (https://github.com/google/Xee) to use Xarray with the EE client.
* pydap
* numpy

Accounts needed:
* NASA EarthData account (change 'username' and 'password' below to yours)
* Earth Engine account (must have run already `earthengine authenticate`)

This script will run for about a minute.
"""

import json
import traceback

import ee
import numpy as np
from osgeo import gdal
from pydap.cas.urs import setup_session
import requests
import xarray


SIN = """PROJCS["MODIS Sinusoidal",
    GEOGCS["WGS 84",
        DATUM["WGS_1984",
            SPHEROID["WGS 84",6378137,298.257223563,
                AUTHORITY["EPSG","7030"]],
            AUTHORITY["EPSG","6326"]],
        PRIMEM["Greenwich",0,
            AUTHORITY["EPSG","8901"]],
        UNIT["degree",0.01745329251994328,
            AUTHORITY["EPSG","9122"]],
        AUTHORITY["EPSG","4326"]],
    PROJECTION["Sinusoidal"],
    PARAMETER["false_easting",0.0],
    PARAMETER["false_northing",0.0],
    PARAMETER["central_meridian",0.0],
    PARAMETER["semi_major",6371007.181],
    PARAMETER["semi_minor",6371007.181],
    UNIT["m",1.0],
    AUTHORITY["SR-ORG","6974"]]"""

# Example code to optionally read a local file as a third point of reference.
"""filename = 'HDF4_EOS:EOS_GRID:"/tmp/MCD43A4.A2000055.h22v10.061.2020038135111.hdf":MOD_Grid_BRDF:Nadir_Reflectance_Band1'
gdal_data = gdal.Open(filename).ReadAsArray()
gdal_data1 = gdal_data.astype(np.float32)
gdal_data1[gdal_data1==32767] = np.nan

filename2 = '/tmp/modis_test4.tif'
gdal_data2 = gdal.Open(filename2).ReadAsArray()
gdal_data3 = gdal_data2.astype(np.float32)
gdal_data3[gdal_data3==0] = np.nan

print(np.isclose(gdal_data1, gdal_data3, equal_nan=True).all())"""


def compare(
    concept_id: str,
    nasa_band: str,
    collection_id: str,
    ee_fill_value: float,
    ee_band: str,
    ee_scale: float,
):
  """Compares data read from NASA and from EE."""
  cmr_url = (
      'https://cmr.earthdata.nasa.gov/search/granules.json?collection_concept_id=%s&sort_key[]=start_date&page_size=1'
      % concept_id
  )
  if collection_id == 'TOMS/MERGED':
    cmr_url += '&temporal[]=2006-01-01T10:00:00Z,2006-01-02T00:00:00Z'
  cmr_data = requests.get(cmr_url).json()
  opendap_url = None
  print(json.dumps(cmr_data['feed']['entry'], sort_keys=True, indent=2))
  for entry in cmr_data['feed']['entry']:
    for link in entry['links']:
      if link.get('title', '').startswith(
          'The OPENDAP location for the granule'
      ):
        opendap_url = link['href']
        break
      if 'opendap' in link['href']:
        # MODIS URLs returned by CMR like
        # https://opendap.cr.usgs.gov/opendap/hyrax/DP130/MOTA/MCD43A1.061/contents.html
        # are top level and don't point at endpoints we can use directly.
        # Use one of these formats instead:
        # opendap_url = (
        #  'https://opendap.cr.usgs.gov/opendap/hyrax/DP130/MOTA/MCD43A1.061/2000.02.24/MCD43A1.A2000055.h00v08.061.2020038135030.hdf'
        # )
        opendap_url = (
            'https://opendap.cr.usgs.gov/opendap/hyrax/MCD43A4.061/h22v10.ncml'
        )
    if opendap_url:
      break
  if not opendap_url:
    raise ValueError('No OpenDAP links for %s' % concept_id)
  print(opendap_url)

  try:
    opendap_session = setup_session('username', 'password')
    # Despite this session setup, reading the data from an opendap dataset
    # doesn't work unless we hardcode the token auth header at the
    # low level in webob/client.py, in SendRequest.__call__ just before
    # the request is made:
    # "Authorization": f"Bearer {token}"
    nasa_dataset = xarray.open_dataset(
        opendap_url, engine='pydap', session=opendap_session
    )
  except Exception as e:  # pylint:disable=broad-exception-caught
    traceback.print_exception(e)

  # Define the Earth Engine collection.
  collection = ee.ImageCollection(collection_id)
  if collection_id == 'NASA/GPM_L3/IMERG_V06':
    collection = collection.filterMetadata('status', 'equals', 'permanent')
  elif collection_id == 'TOMS/MERGED':
    collection = collection.filterDate('2006-01-01', '2006-01-02')
  collection = collection.select(ee_band)

  kwargs = {'engine': 'ee', 'ee_mask_value': ee_fill_value}
  if ee_scale:
    kwargs['scale'] = ee_scale
  if collection_id == 'MODIS/061/MCD43A4':
    # This should work, but doesn't. See
    # https://github.com/google/Xee/issues/112
    kwargs['geometry'] = ee.Geometry.Rectangle(
        [4447800, -2223901, 4448801, -2222900],
        ee.Projection(SIN),
        False,
        True,
    )

    kwargs['crs'] = SIN
    kwargs['projection'] = ee.Projection(SIN)

  # Open the Earth Engine dataset
  image = ee.ImageCollection(collection.first())
  ds = xarray.open_dataset(image, **kwargs)
  ee_image = getattr(ds, ee_band)
  # Take the first element of the EE ImageCollection
  ee_data = ee_image[0].data
  if collection_id == 'TRMM/3B43V7':
    # Strip out nodata areas above 50N and below 50S
    # TODO(simonf): we should use the proper rectangle with xee instead.
    ee_data = ee_data[:, 160:560]

  # Access the variable from the NASA dataset
  nasa_image = nasa_dataset[nasa_band]
  # Get the first time slice, creating a local copy
  # to avoid constantly refetching the bytes.
  if collection_id in ['NASA/GPM_L3/IMERG_V06', 'MODIS/061/MCD43A4']:
    first_nasa_image = np.copy(nasa_image[0, :, :])
  else:
    first_nasa_image = np.copy(nasa_image[:, :])

  if collection_id == 'TOMS/MERGED':
    nasa_data = np.rot90(first_nasa_image)
    nasa_data = np.flip(nasa_data, axis=0)
  else:
    nasa_data = first_nasa_image
  # Flip verically so that north is up
  nasa_data = np.flip(nasa_data, axis=1)

  # Print the shape of the first time slice of data from Earth Engine
  print(ee_data.shape)
  # Print the shape of the rotated first time slice of data from OpenDAP
  print(nasa_data.shape)

  if ee_data.shape != nasa_data.shape:
    raise ValueError(
        'Shape mismatch: EE %s vs NASA %s'
        % (ee_data.shape, first_nasa_image.shape)
    )

  # Optionally print a subset for visual inspection.
  # ee_subset = ee_data[500][1200:1300]
  # nasa_subset = nasa_data[500][1200:1300]

  # np.set_printoptions(precision=6, floatmode='fixed')

  # print('Earth Engine data subset')
  # print(ee_subset)
  # print('NASA data subset')
  # print(nasa_subset)

  # Compare a specific range of data values from all datasets
  print('NASA vs EE')
  # Use the np.isclose() comparison instead of the == comparison
  # to ignore np.nan values that are never equal to each other.
  print(np.isclose(ee_data, nasa_data, equal_nan=True).all())


def main(unused_argv):
  ee.Initialize()
  compare(
      'C1598621093-GES_DISC',
      'precipitationCal',
      'NASA/GPM_L3/IMERG_V06',
      2.1474836e09,
      'precipitationCal',
      0.1,
  )
  compare(
      'C1282032631-GES_DISC',
      'precipitation',
      'TRMM/3B43V7',
      2.1474836e09,
      'precipitation',
      0.25,
  )
  compare(
      'C1266136070-GES_DISC',
      'ColumnAmountO3',
      'TOMS/MERGED',
      2.1474836e09,
      'ozone',
      1,
  )
  compare(
      'C2218719731-LPCLOUD',
      'Nadir_Reflectance_Band1',
      'MODIS/061/MCD43A4',
      2.1474836e09,
      'Nadir_Reflectance_Band1',
      463.3127165279165,
  )


if __name__ == '__main__':
  main([])
