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

ee.Initialize()

# Define the Earth Engine collection and filter it by 'permanent' status
collection = ee.ImageCollection('NASA/GPM_L3/IMERG_V06').filterMetadata(
    'status', 'equals', 'permanent'
).select('precipitationCal')

# Open the Earth Engine dataset using native scale of 0.1 degrees
# and access the 'precipitationCal' band.
ee_precip = xarray.open_dataset(
    collection, engine='ee', scale=0.1, ee_mask_value=2.1474836e+09
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

# Access the 'precipc' variable from the NASA dataset
nasa_precip = nasa_dataset['precipc']
# Get the first time slice, creating a local copy
# to avoid constantly refetching the bytes.
first_nasa_precip = np.copy(nasa_precip[0, :, :])

# Print the shape of the first time slice of data from Earth Engine
print(first_ee_precip.shape)
# Print the shape of the rotated first time slice of data from OpenDAP
print(np.rot90(first_nasa_precip[0]).shape)
# All print (3600, 1800)

# Take the first element of the EE ImageCollection
ee_data = ee_precip[0].data
# Rotate the first time slice of data from OpenDAP
# Also, flip verically so that north is up
nasa_data = np.flip(np.rot90(first_nasa_precip[0]))

ee_data[ee_data > 2.14748e9] = np.nan
# Mask NASA nodata value
nasa_data[nasa_data == -9999.900391] = np.nan

ee_subset = ee_data[500][1200:1300]
nasa_subset = nasa_data[500][1200:1300]

np.set_printoptions(precision=6, floatmode='fixed')

print('Earth Engine data subset')
print(ee_subset)
print('NASA data subset')
print(nasa_subset)

# Compare a specific range of data values from all datasets
print('NASA vs EE')
# Use the np.isclose() comparison instead of the == comparison
# to ignore np.nan values that are never equal to each other.
print(np.isclose(ee_data, nasa_data, equal_nan=True).all())

# pylint:disable=pointless-string-statement
"""
Full output

Earth Engine data subset
[0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 3.669067e-03 2.751800e-03 5.503601e-03 1.375900e-03 0.000000e+00
 1.639845e-02 8.796404e-02 2.309320e-01 4.704733e-01 3.158820e-01
 1.845790e+00 3.801518e+00 3.703153e+00 6.971351e+00 7.371814e+00
 7.146841e+00 7.114139e+00 3.520790e+00 2.941954e+00 2.829440e+00
 2.817868e+00 1.288270e+00 1.017063e+00 1.310689e+00 2.737879e-01
 9.560879e-02 3.467628e-01 1.717419e-01 2.595865e-01 2.073023e-01
 1.935433e-01 8.622308e-02 5.962234e-02 9.631301e-02 1.275001e-01
 1.829947e-01 1.586872e-01 1.495145e-01 2.831617e-01 2.993204e-01
 1.503622e-01 1.109893e-01 8.071948e-02 1.367663e-01 2.101814e-01
 2.357342e-01 3.077800e-01 1.467795e-01 1.215097e-01 3.529568e-01
 5.207559e-01 5.612592e-01 8.158509e-01 8.910712e-01 8.852851e-01
 4.686803e-01 5.908247e-01 3.008812e-01 3.008812e-01 1.446544e-01
 2.198747e-01 2.314471e-02 1.011517e-02 2.739871e-02 4.311154e-02
 5.188262e-02 5.411874e-02 5.320147e-02 1.651080e-02 2.751800e-02
 1.926260e-02 2.072763e-02 1.968062e-02 1.926260e-02 2.390757e-02
 2.550633e-02 2.282893e-02 1.742807e-02 1.742807e-02 8.255401e-03
 1.834534e-03 1.834534e-03 1.375900e-02 1.284174e-02 1.284174e-02]
NASA data subset
[0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
 3.669067e-03 2.751800e-03 5.503601e-03 1.375900e-03 0.000000e+00
 1.639845e-02 8.796404e-02 2.309320e-01 4.704733e-01 3.158820e-01
 1.845790e+00 3.801518e+00 3.703153e+00 6.971351e+00 7.371814e+00
 7.146841e+00 7.114139e+00 3.520790e+00 2.941954e+00 2.829440e+00
 2.817868e+00 1.288270e+00 1.017063e+00 1.310689e+00 2.737879e-01
 9.560879e-02 3.467628e-01 1.717419e-01 2.595865e-01 2.073023e-01
 1.935433e-01 8.622308e-02 5.962234e-02 9.631301e-02 1.275001e-01
 1.829947e-01 1.586872e-01 1.495145e-01 2.831617e-01 2.993204e-01
 1.503622e-01 1.109893e-01 8.071948e-02 1.367663e-01 2.101814e-01
 2.357342e-01 3.077800e-01 1.467795e-01 1.215097e-01 3.529568e-01
 5.207559e-01 5.612592e-01 8.158509e-01 8.910712e-01 8.852851e-01
 4.686803e-01 5.908247e-01 3.008812e-01 3.008812e-01 1.446544e-01
 2.198747e-01 2.314471e-02 1.011517e-02 2.739871e-02 4.311154e-02
 5.188262e-02 5.411874e-02 5.320147e-02 1.651080e-02 2.751800e-02
 1.926260e-02 2.072763e-02 1.968062e-02 1.926260e-02 2.390757e-02
 2.550633e-02 2.282893e-02 1.742807e-02 1.742807e-02 8.255401e-03
 1.834534e-03 1.834534e-03 1.375900e-02 1.284174e-02 1.284174e-02]
NASA vs EE
True
"""
