#!/usr/bin/python3
"""This is a script for an ad hoc comparison of NASA and EE data.

The script reads the same GPM IMERG data at NASA
(https://gpm1.gesdisc.eosdis.nasa.gov/dods/GPM_3IMERGHH_06)
and its copy in Google Earth Engine
(https://developers.google.com/earth-engine/datasets/catalog/NASA_GPM_L3_IMERG_V06).
This dataset has global 3600x1800 images (i.e., with the scale of 0.1 degree).

Prerequsites:
* Earth Engine client
* xee (https://github.com/google/Xee) to use Xarray with the EE client.
* pydap
* numpy
* osgeo.gdal

Accounts needed:
* NASA EarthData account (change 'username' and 'password' below to yours)
* Earth Engine account (must have run already `earthengine authenticate`)

This script will run for about a minute.
"""

import ee
import numpy as np
from osgeo import gdal
from pydap.cas.urs import setup_session
from pydap.client import open_url
import xarray

# See
# https://gpm1.gesdisc.eosdis.nasa.gov/data/GPM_L3/GPM_3IMERGHH.06/2000/153/3B-HHR.MS.MRG.3IMERG.20000601-S000000-E002959.0000.V06B.HDF5
filename = 'HDF5:"/tmp/3B-HHR.MS.MRG.3IMERG.20000601-S000000-E002959.0000.V06B.HDF5"://Grid/precipitationCal'
gdal_precip = gdal.Open(filename).ReadAsArray()

ee.Initialize()

# Define the Earth Engine collection and filter it by 'permanent' status
collection = ee.ImageCollection('NASA/GPM_L3/IMERG_V06').filterMetadata(
    'status', 'equals', 'permanent'
)
# Open the Earth Engine dataset using native scale of 0.1 degrees
# and access the 'precipitationCal' band.
ee_precip = xarray.open_dataset(
    collection, engine='ee', scale=0.1
).precipitationCal
first_ee_precip = ee_precip[0]

opendap_url = 'https://gpm1.gesdisc.eosdis.nasa.gov/dods/GPM_3IMERGHH_06'
opendap_session = setup_session('username', 'password', check_url=opendap_url)
# Access the dataset from the OpenDAP URL
nasa_dataset = open_url(opendap_url, session=opendap_session)

# Count the number of time slices in the Earth Engine dataset
num_slices_ee = len(ee_precip.time)
# Count the number of time slices in the OpenDAP dataset
num_slices_nasa = len(nasa_dataset['time'])

# Print the number of time slices from both datasets
print(f'NASA num_slices: {num_slices_nasa}')
print(f'EE num_slices: {num_slices_ee}')
# Both print 374016

# Access the 'hqprecip' variable from the NASA dataset
nasa_precip = nasa_dataset['hqprecip']
# Get the first time slice, creating a local copy
# to avoid constantly refetching the bytes.
first_nasa_precip = np.copy(nasa_precip[0, :, :])

# Print the shape of the array read from GDAL
print(gdal_precip.shape)
# Print the shape of the first time slice of data from Earth Engine
print(first_ee_precip.shape)
# Print the shape of the rotated first time slice of data from OpenDAP
print(np.rot90(first_nasa_precip[0]).shape)
# All print (3600, 1800)

gdal_normalized = np.flip(gdal_precip)
# Flip verically the first time slice of data from Earth Engine
# so that north is up
ee_normalized = np.flip(ee_precip[0])
# Rotate the first time slice of data from OpenDAP
nasa_normalized = np.rot90(first_nasa_precip[0])

# Select a specific range of data values from all datasets
# TODO(simonf): I am confused why we need to reverse the list from GDAL.
# The lon range in the file is -180 to 180
gdal_subset = np.array(list(reversed(gdal_normalized[500])))[870:970]
ee_subset = ee_normalized[500][870:970].data
nasa_subset = nasa_normalized[500][870:970]

np.set_printoptions(precision=6, floatmode='fixed')

print('GDAL data from file')
print(gdal_subset)
print('Earth Engine data')
print(ee_subset)
print('NASA data')
print(nasa_subset)

# Compare a specific range of data values from all datasets
print('NASA vs GDAL')
print(nasa_subset == gdal_subset)
print('NASA vs EE')
print(nasa_subset == ee_subset)
print('EE vs GDAL')
print(ee_subset == gdal_subset)

# This prints 96 when 4 out of 100 values are not the same.
# See below for the full printout.
print('NASA vs GDAL sum')
print(sum(nasa_subset == ee_subset))
print('NASA vs EE sum')
print(sum(nasa_subset == ee_subset))
print('EE vs GDAL sum')
print(sum(ee_subset == gdal_subset))

# pylint:disable=pointless-string-statement
"""
Full output

GDAL data from file
[0.101135 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.133421 0.037022 0.049846 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.030000 0.000000 0.580000 0.590000 0.580000 0.500000 0.000000
 0.000000 0.000000 0.000000 0.550000 0.600000 0.600000 0.590000 0.530000
 0.470000 0.550000 0.540000 0.970000 0.970000 0.950000 0.800000 0.920000
 0.310000 0.310000 0.310000 0.050000 0.040000 0.040000 0.040000 0.000000
 0.050000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.020000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000]
Earth Engine data
[0.101135 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.133421 0.037022 0.049846 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.030000 0.000000 0.580000 0.590000 0.580000 0.500000 0.000000
 0.000000 0.000000 0.000000 0.550000 0.600000 0.600000 0.590000 0.530000
 0.470000 0.550000 0.540000 0.970000 0.970000 0.950000 0.800000 0.920000
 0.310000 0.310000 0.310000 0.050000 0.040000 0.040000 0.040000 0.000000
 0.050000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.020000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000]
NASA data
[0.050000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.140000 0.030000 0.040000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.030000 0.000000 0.580000 0.590000 0.580000 0.500000 0.000000
 0.000000 0.000000 0.000000 0.550000 0.600000 0.600000 0.590000 0.530000
 0.470000 0.550000 0.540000 0.970000 0.970000 0.950000 0.800000 0.920000
 0.310000 0.310000 0.310000 0.050000 0.040000 0.040000 0.040000 0.000000
 0.050000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.020000
 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
 0.000000 0.000000 0.000000 0.000000]
NASA vs GDAL
[False  True  True  True  True  True  True  True  True False False False
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True]
NASA vs EE
[False  True  True  True  True  True  True  True  True False False False
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True]
EE vs GDAL
[ True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True]
NASA vs GDAL sum
96
NASA vs EE sum
96
EE vs GDAL sum
100
"""
