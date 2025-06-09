local id = 'NOAA/VIIRS/AOD_EDR/V3';
local subdir = 'NOAA';
local version = '3';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'VIIRS Aerosol Optical Depth and Aerosol Particle Size EDRs V' + version,
  version: version,

  // TODO(dpencosk): Improve the dataset description.
  description: |||
    The VIIRS Aerosol Optical Depth and Aerosol Particle Size EDRs product
    provides raw coordinates and observations at a spatial resolution of 750
    meters. This dataset contains geocorrected rasters projected into a north-up
    lat-lon grid using a Geographic Lookup Table (GLT). Source files that cross
    the antimeridian yield two assets, one for each hemisphere. For more
    details, see the theoretical basis document at
    https://www.star.nesdis.noaa.gov/jpss/documents/ATBD/ATBD_EPS_Aerosol_AOD_v3.4.pdf.
  |||,

  'gee:categories': ['atmosphere'],

  keywords: [
    'aod',
    'aerosol',
    'noaa',
    'viirs',
  ],

  providers: [
    ee.producer_provider('NOAA', 'https://www.noaa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global(
      // TODO(dpencosk): Add start date.
      '2006-01-24T00:00:00Z',
      null
  ),

  summaries: {
    gsd: [750],
    'eo:bands': [
      {
        name: 'AOD550',
        description: 'Retrieved aerosol optical depth at 550 nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD_channel_M1',
        description: 'Retrieved aerosol optical depth in sensor channel M1',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.412 &mu;m',
      },
      {
        name: 'AOD_channel_M2',
        description: 'Retrieved aerosol optical depth in sensor channel M2',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.445 &mu;m',
      },
      {
        name: 'AOD_channel_M3',
        description: 'Retrieved aerosol optical depth in sensor channel M3',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.488 &mu;m',
      },
      {
        name: 'AOD_channel_M4',
        description: 'Retrieved aerosol optical depth in sensor channel M4',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.555 &mu;m',
      },
      {
        name: 'AOD_channel_M5',
        description: 'Retrieved aerosol optical depth in sensor channel M5',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.672 &mu;m',
      },
      {
        name: 'AOD_channel_M6',
        description: 'Retrieved aerosol optical depth in sensor channel M6',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.746 &mu;m',
      },
      {
        name: 'AOD_channel_M7',
        description: 'Retrieved aerosol optical depth in sensor channel M7',
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.865 &mu;m',
      },
      {
        name: 'AOD_channel_M8',
        description: 'Retrieved aerosol optical depth in sensor channel M8',
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.24 &mu;m',
      },
      {
        name: 'AOD_channel_M9',
        description: 'Retrieved aerosol optical depth in sensor channel M9',
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.378 &mu;m',
      },
      {
        name: 'AOD_channel_M10',
        description: 'Retrieved aerosol optical depth in sensor channel M10',
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.61 &mu;m',
      },
      {
        name: 'AOD_channel_M11',
        description: 'Retrieved aerosol optical depth in sensor channel M11',
        'gee:units': units.dimensionless,
        'gee:wavelength': '2.25 &mu;m',
      },
      {
        name: 'AngsExp1',
        description: |||
          Angstrom Exponent calculated from AOD at M4 and M7 over ocean (M3 and
          M7 for ABI)
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'AngsExp2',
        description: |||
          Angstrom Exponent calculated from AOD at M7 and M10 over ocean
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'SfcRefl_M1',
        description: |||
          Surface reflectance of land and ocean for sensor channel M1
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.412 &mu;m',
      },
      {
        name: 'SfcRefl_M2',
        description: |||
          Surface reflectance of land and ocean for sensor channel M2
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.445 &mu;m',
      },
      {
        name: 'SfcRefl_M3',
        description: |||
          Surface reflectance of land and ocean for sensor channel M3
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.488 &mu;m',
      },
      {
        name: 'SfcRefl_M4',
        description: |||
          Surface reflectance of land and ocean for sensor channel M4
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.555 &mu;m',
      },
      {
        name: 'SfcRefl_M5',
        description: |||
          Surface reflectance of land and ocean for sensor channel M5
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.672 &mu;m',
      },
      {
        name: 'SfcRefl_M6',
        description: |||
          Surface reflectance of land and ocean for sensor channel M6
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.746 &mu;m',
      },
      {
        name: 'SfcRefl_M7',
        description: |||
          Surface reflectance of land and ocean for sensor channel M7
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '0.865 &mu;m',
      },
      {
        name: 'SfcRefl_M8',
        description: |||
          Surface reflectance of land and ocean for sensor channel M8
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.24 &mu;m',
      },
      {
        name: 'SfcRefl_M9',
        description: |||
          Surface reflectance of land and ocean for sensor channel M9
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.378 &mu;m',
      },
      {
        name: 'SfcRefl_M10',
        description: |||
          Surface reflectance of land and ocean for sensor channel M10
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '1.61 &mu;m',
      },
      {
        name: 'SfcRefl_M11',
        description: |||
          Surface reflectance of land and ocean for sensor channel M11
        |||,
        'gee:units': units.dimensionless,
        'gee:wavelength': '2.25 &mu;m',
      },
      {
        name: 'SpaStddev',
        description: |||
          3 by 3 standard deviation of TOAreflectance at M1/M11 (land/ocean)
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'Residual',
        description: 'Retrieval residual of best solution',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550LndMdl_Dust',
        description: 'Retrieved AOD at 550nm for the dust land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550LndMdl_Generic',
        description: |||
          Retrieved AOD at 550nm for the generic land aerosol model'
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550LndMdl_Urban',
        description: 'Retrieved AOD at 550nm for the urban land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550LndMdl_Smoke',
        description: 'Retrieved AOD at 550nm for the smoke land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'ResLndMdl_Dust',
        description: 'Retrieval residual for the dust land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'ResLndMdl_Generic',
        description: 'Retrieval residual for the generic land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'ResLndMdl_Urban',
        description: 'Retrieval residual for the urban land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'ResLndMdl_Smoke',
        description: 'Retrieval residual for the smoke land aerosol model',
        'gee:units': units.dimensionless,
      },
      {
        name: 'FineMdlIdx',
        description: 'Index of fine mode aerosol model over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'CoarseMdlIdx',
        description: 'Index of coarse mode aerosol model over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'FineModWgt',
        description: 'Fine mode weight over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AerMdl',
        description: |||
          Aerosol model selected from prescribed models during the retrieval:

          * 0: oceanic aerosol
          * 1: dust over land
          * 2: generic aerosol over land
          * 3: urban aerosol over land
          * 4: smoke over land
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'QCAll',
        description: |||
          Overall quality flag for aerosol optical depth retrieval:

          * 0: high quality
          * 1: medium quality
          * 2: low quality
          * 3: no retrieval
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'QCAE',
        description: |||
          Overall quality flag for Angstrom Exponent retrieval over ocean:

          * 0: high quality
          * 1: medium quality
          * 2: low quality
          * 3: no retrieval
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'QCExtn',
        description: |||
          Quality flag describing the external (or input) masks. For each
          "yes/no" bit, a "yes" value indicates the presence of that mask.
        |||,
        'gee:units': units.dimensionless,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Input cloud mask',
              bit_count: 2,
              first_bit: 0,
              values: [
                {value: 0, description: 'confidently clear'},
                {value: 1, description: 'probably clear'},
                {value: 2, description: 'probably cloudy'},
                {value: 3, description: 'confidently cloudy'},
              ],
            },
            {
              description: 'Input snow mask',
              bit_count: 1,
              first_bit: 2,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Input cloud shadow mask',
              bit_count: 1,
              first_bit: 3,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Input fire mask',
              bit_count: 1,
              first_bit: 4,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Input glint mask',
              bit_count: 1,
              first_bit: 5,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Input heavy aerosol mask',
              bit_count: 1,
              first_bit: 6,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Ephemeral water from input land/water mask',
              bit_count: 1,
              first_bit: 7,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QCTest',
        description: |||
          Quality flag describing internal tests for specific conditions that
          may impact or hinder AOD computation. For each "yes/no" bit, a
          "yes" value indicates presence of the feature being tested.
        |||,
        'gee:units': units.dimensionless,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud test',
              bit_count: 1,
              first_bit: 0,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Cirrus test',
              bit_count: 1,
              first_bit: 1,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Thin cirrus test',
              bit_count: 1,
              first_bit: 2,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Inhomogeneity test',
              bit_count: 1,
              first_bit: 3,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Snow/ice test',
              bit_count: 1,
              first_bit: 4,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Ephemeral water test',
              bit_count: 1,
              first_bit: 5,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Shallow water test',
              bit_count: 1,
              first_bit: 6,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Heavy aerosol test',
              bit_count: 1,
              first_bit: 7,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QCInput',
        description: |||
          Quality flag describing the types of bad inputs that impact or hinder
          AOD computation.. For each "yes/no" bit, a "yes" value indicates that
          the input has the specified problem.
        |||,
        'gee:units': units.dimensionless,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Input location',
              bit_count: 1,
              first_bit: 0,
              values: [
                {value: 0, description: 'good'},
                {
                  value: 1,
                  description: |||
                    bad, if

                    1. longitude beyond [-180°,180°]
                    2. latitude beyond [-90°,90°]
                  |||,
                },
              ],
            },
            {
              description: 'Input geometry',
              bit_count: 1,
              first_bit: 1,
              values: [
                {value: 0, description: 'good'},
                {
                  value: 1,
                  description: |||
                    bad, if

                    1. zenith angle beyond [0°,90°]
                    2. azimuth angle beyond [-360°,360°]
                  |||,
                },
              ],
            },
            {
              description: 'Input ancillary data',
              bit_count: 1,
              first_bit: 2,
              values: [
                {value: 0, description: 'good'},
                {
                  value: 1,
                  description: |||
                    bad, if

                    1. TPW beyond [0,20] cm
                    2. ozone beyond [0,1] atm-cm
                    3. surface pressure beyond [500,1500] mb
                    4. wind speed beyond [0,100] m/s
                    5. wind direction beyond [0°,360°]
                  |||,
                },
              ],
            },
            {
              description: 'Input reflectance and brightness temperature',
              bit_count: 1,
              first_bit: 3,
              values: [
                {value: 0, description: 'good'},
                {
                  value: 1,
                  description: |||
                    bad, if

                    1. M1-M11 reflectance beyond [0,1]
                    2. M15 or M16 brightness temperature beyond [200,350] K
                    3. M6 reflectance is saturated
                  |||,
                },
              ],
            },
            {
              description: 'Shallow ocean from input land/water mask',
              bit_count: 1,
              first_bit: 4,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Shallow inland water from input land/water mask',
              bit_count: 1,
              first_bit: 5,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Coast line from input land/water mask',
              bit_count: 1,
              first_bit: 6,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
          ],
          total_bit_count: 7,
        },
      },
      {
        name: 'QCPath',
        description: |||
          Quality flag describing the retrieval paths/schemes. For each "yes/no"
          bit, a "yes" value indicates the presence of that feature.
        |||,
        'gee:units': units.dimensionless,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Pixel over water',
              bit_count: 1,
              first_bit: 0,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Bright land surface',
              bit_count: 1,
              first_bit: 1,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Sunglint over water',
              bit_count: 1,
              first_bit: 2,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'SW scheme over dark land',
              bit_count: 1,
              first_bit: 3,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'SWIR scheme over dark land',
              bit_count: 1,
              first_bit: 4,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Retrieval over bright land',
              bit_count: 1,
              first_bit: 5,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Retrieval over bright land with dark land scheme',
              bit_count: 1,
              first_bit: 6,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
          ],
          total_bit_count: 7,
        },
      },
      {
        name: 'QCRet',
        description: |||
          Quality flag describing problems arising from data retrieval that may
          impact or hinder AOD computation. For each "yes/no" bit, a "yes"
          value indicates that retrieval failed for that reason.
        |||,
        'gee:units': units.dimensionless,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Retrieval failed',
              bit_count: 1,
              first_bit: 0,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Large airmass',
              bit_count: 1,
              first_bit: 1,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Barren land cover type',
              bit_count: 1,
              first_bit: 2,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Extrapolation',
              bit_count: 1,
              first_bit: 3,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
            {
              description: 'Large residual',
              bit_count: 1,
              first_bit: 4,
              values: [
                {value: 0, description: 'no'},
                {
                  value: 1,
                  description: |||
                    yes (Larger than 0.5 over land; 0.3 over ocean)'
                  |||,
                },
              ],
            },
            {
              description: 'NDVI_SWIR out-of-range',
              bit_count: 1,
              first_bit: 5,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes (Beyond [-0.1,0.8] over land)'},
              ],
            },
            {
              description: 'Redness ratio out-of-range',
              bit_count: 1,
              first_bit: 6,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes (Beyond [0.4,1.6] over land)'},
              ],
            },
            {
              description: 'Adjacent to cloud or snow',
              bit_count: 1,
              first_bit: 7,
              values: [
                {value: 0, description: 'no'},
                {value: 1, description: 'yes'},
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
    ],

    // TODO(dpencosk): Add band statistics.
    // band_name_1: {minimum: 0, maximum: 255, 'gee:estimated_range': false},

    // TODO(dpencosk): Add a valid visualization.
    'gee:visualizations': [
      {
        display_name: 'AOD 550nm',
        lookat: {lon: 0, lat: 0, zoom: 2},
        image_visualization: {
          band_vis: {
            bands: ['AOD550'],
          },
        },
      },
    ],

    'gee:schema': [
      {
        name: 'version',
        description: 'Product version',
        type: ee_const.var_type.int,
      },
      {
        name: 'revision',
        description: 'Product revision',
        type: ee_const.var_type.int,
      },
      {
        name: 'creation_time',
        description: 'Product creation time (Unix timestamp)',
        type: ee_const.var_type.int,
      },
      {
        name: 'ascend_descend_data_flag',
        description: '0 (ascend) or 1 (descend)',
        type: ee_const.var_type.int,
      },
      {
        name: 'day_night_data_flag',
        description: '"day" or "night"',
        type: ee_const.var_type.string,
      },
      {
        name: 'end_orbit_number',
        description: 'End orbit number',
        type: ee_const.var_type.int,
      },
      {
        name: 'satellite_name',
        description: 'Satellite name: "NOAA-20", "NOAA-21", or "NPP"',
        type: ee_const.var_type.string,
      },
      {
        name: 'start_orbit_number',
        description: 'Start orbit number',
        type: ee_const.var_type.int,
      },
    ],
  },

  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },

  'gee:terms_of_use': |||
    There are no restrictions on the use of JPSS data, and it can be used or
    redistributed as desired.
  |||,

  'gee:status': 'incomplete',

  'gee:type': ee_const.gee_type.image_collection,

  // TODO(dpencosk): Unsure if we can use spdx.cc0_1_0 here.
  license: spdx.proprietary.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    // ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}