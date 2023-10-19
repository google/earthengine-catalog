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

Accounts needed:
* NASA EarthData account (change 'username' and 'password' below to yours)
* Earth Engine account (must have run already `earthengine authenticate`)

This script will run for about a minute.
"""

import ee
import numpy as np
from pydap.cas.urs import setup_session
from pydap.client import open_url
import xarray

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

# Print the shape of the first time slice of data from Earth Engine
print(first_ee_precip.shape)
# Print the shape of the rotated first time slice of data from OpenDAP
print(np.rot90(first_nasa_precip[0]).shape)
# Both print (3600, 1800)

# Flip verically the first time slice of data from Earth Engine
# so that north is up
ee_normalized = np.flip(ee_precip[0])
# Rotate the first time slice of data from OpenDAP
nasa_normalized = np.rot90(first_nasa_precip[0])

# Select a specific range of data values from both datasets
ee_subset = ee_normalized[500][800:1000].data
nasa_subset = nasa_normalized[500][800:1000]
print(ee_subset)
print(nasa_subset)

# Compare the specific range of data values from both datasets
print(nasa_subset == ee_subset)

print(sum(nasa_subset == ee_subset))
# This prints 196 because 4 out of 200 values are not the same.
# See below for the full printout.

# pylint:disable=pointless-string-statement
"""
Full output

Earth Engine data

[0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.22
 0.21       0.21       0.52       0.32       0.32       0.34
 0.14       0.14       0.         0.         0.         0.
 0.48999998 0.64       0.64       0.87       1.02       0.66999996
 0.24       0.07       0.         0.         0.         0.
 0.         0.         0.         0.         0.10113539 0.
 0.         0.         0.         0.         0.         0.
 0.         0.13342088 0.0370223  0.04984601 0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.03
 0.         0.58       0.59       0.58       0.5        0.
 0.         0.         0.         0.55       0.59999996 0.59999996
 0.59       0.53       0.47       0.55       0.53999996 0.96999997
 0.96999997 0.95       0.79999995 0.91999996 0.31       0.31
 0.31       0.05       0.04       0.04       0.04       0.
 0.05       0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.02       0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.        ]

NASA data

[0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.22
 0.21       0.21       0.52       0.32       0.32       0.34
 0.14       0.14       0.         0.         0.         0.
 0.48999998 0.64       0.64       0.87       1.02       0.66999996
 0.24       0.07       0.         0.         0.         0.
 0.         0.         0.         0.         0.05       0.
 0.         0.         0.         0.         0.         0.
 0.         0.14       0.03       0.04       0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.03
 0.         0.58       0.59       0.58       0.5        0.
 0.         0.         0.         0.55       0.59999996 0.59999996
 0.59       0.53       0.47       0.55       0.53999996 0.96999997
 0.96999997 0.95       0.79999995 0.91999996 0.31       0.31
 0.31       0.05       0.04       0.04       0.04       0.
 0.05       0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.02       0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.         0.         0.         0.         0.
 0.         0.        ]

Comparison

[ True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True False  True
  True  True  True  True  True  True  True False False False  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True]

"""
