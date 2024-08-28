local id = 'NOAA/VIIRS/001/VNP46A1';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title:
    'VNP46A1: VIIRS Daily Gridded Day Night Band 500m Linear Lat Lon Grid Night',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-orbiting Partnership (SNPP) Visible Infrared
    Imaging Radiometer Suite (VIIRS) supports a Day-Night Band (DNB) sensor
    that provides global daily measurements of nocturnal visible and
    near-infrared (NIR) light that are suitable for Earth system science and
    applications. The VIIRS DNB's ultra-sensitivity in lowlight conditions
    enables us to generate a new set of science-quality nighttime products that
    manifest substantial improvements in sensor resolution and calibration when
    compared to the previous era of Defense Meteorological Satellite
    Program/Operational Linescan System's (DMSP/OLS) nighttime lights image
    products.

    VNP46A1 is a daily, top-of-atmosphere, at-sensor nighttime radiance product
    called VIIRS/NPP Daily Gridded Day Night Band 15 arc-second Linear Lat Lon
    Grid Night. The product contains 26 Science Data Sets (SDS) that include
    sensor radiance, zenith and azimuth angles (at-sensor, solar, and lunar),
    cloud-mask flags, time, shortwave IR radiance, brightness temperatures,
    VIIRS quality flags, moon phase angle, and moon illumination fraction. It
    also provides Quality Flag (QF) information specific to the cloud-mask,
    VIIRS moderate-resolution bands M10, M11, M12, M13, M15, M16, and DNB.

    Documentation:

    * [User's Guide](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/VIIRS_Black_Marble_UG_v1.3_Sep_2022.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/Product%20Generation%20Algorithms/VIIRS_Black_Marble_ATBD_v1.1_July_2020.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/products/VNP46A1/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP46A1.001',
    },
  ],
  keywords: [
    'daily',
    'dnb',
    'nasa',
    'noaa',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LAADS DAAC', 'https://doi.org/10.5067/VIIRS/VNP46A1.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1373412048-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'BrightnessTemperature_M12',
        description: 'Brightness temperature of band M12',
        'gee:units': units.kelvin,
        'gee:offset': 203,
      },
      {
        name: 'BrightnessTemperature_M13',
        description: 'Brightness temperature of band M13',
        'gee:units': units.kelvin,
        'gee:offset': 203,
      },
      {
        name: 'BrightnessTemperature_M15',
        description: 'Brightness temperature of band M15',
        'gee:units': units.kelvin,
        'gee:offset': 111,
      },
      {
        name: 'BrightnessTemperature_M16',
        description: 'Brightness temperature of band M16',
        'gee:units': units.kelvin,
        'gee:offset': 103,
      },
      {
        name: 'DNB_At_Sensor_Radiance_500m',
        description: 'At-sensor DNB radiance',
      },
      {
        name: 'Glint_Angle',
        description: 'Moon glint angle',
        'gee:units': units.degree
      },
      {
        name: 'Granule',
        description: 'Number of selected Granule',
      },
      {
        name: 'Lunar_Zenith',
        description: 'Lunar zenith angle',
        'gee:units': units.degree
      },
      {
        name: 'Lunar_Azimuth',
        description: 'Lunar azimuth angle',
        'gee:units': units.degree
      },
      {
        name: 'Moon_Illumination_Fraction',
        description: 'Moon illumination fraction',
        'gee:units': units.percent
      },
      {
        name: 'Moon_Phase_Angle',
        description: 'Moon phase angle',
        'gee:units': units.degree
      },
      {
        name: 'QF_Cloud_Mask',
        description: 'Quality flag for cloud mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Day/Night',
              bit_count: 1,
              values: [
                {
                  description: 'Night',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Land/Water Background',
              first_bit: 1,
              bit_count: 3,
              values: [
                {
                  value: 0,
                  description: 'Land & Desert',
                },
                {
                  value: 1,
                  description: 'Land no Desert',
                },
                {
                  value: 2,
                  description: 'Inland Water',
                },
                {
                  value: 3,
                  description: 'Sea Water',
                },
                {
                  value: 5,
                  description: 'Coastal',
                },
              ],
            },
            {
              description: 'Cloud Mask Quality',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Poor',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cloud Detection Results & Confidence Indicator',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: ' Confident Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Probably Clear',
                },
                {
                  value: 2,
                  description: 'Probably Cloudy',
                },
                {
                  value: 3,
                  description: 'Confident Cloudy',
                },
              ],
            },
            {
              description: 'Shadow Detected',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Cirrus Detection (IR) (BTM15 - BTM16)',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'No cloud',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud',
                },
              ],
            },
            {
              description: 'Snow/Ice Surface',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No Snow/Ice',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow/Ice',
                },
              ],
            },
          ],
          total_bit_count: 11,
        },
      },
      {
        name: 'QF_DNB',
        description: 'DNB quality flag',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 16,
            description: 'Stray_light'
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M10',
        description: 'Quality flag of band M10',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M11',
        description: 'Quality flag of band M11',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M12',
        description: 'Quality flag of band M12',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M13',
        description: 'Quality flag of band M13',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M15',
        description: 'Quality flag of band M15',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'QF_VIIRS_M16',
        description: 'Quality flag of band M16',
        'gee:classes': [
          {
            value: 1,
            description: 'Substitute_Cal'
          },
          {
            value: 2,
            description: 'Out_of_Range',
          },
          {
            value: 4,
            description: 'Saturation'
          },
          {
            value: 8,
            description: 'Temp_not_Nominal',
          },
          {
            value: 256,
            description: 'Bowtie_Deleted',
          },
          {
            value: 512,
            description: 'Missing_EV'
          },
          {
            value: 1024,
            description: 'Cal_Fail',
          },
          {
            value: 2048,
            description: 'Dead_Detector'
          },
        ]
      },
      {
        name: 'Radiance_M10',
        description: 'Radiance in band M10',
        'gee:offset': -0.04,
      },
      {
        name: 'Radiance_M11',
        description: 'Radiance in band M11',
        'gee:offset': -0.02,
      },
      {
        name: 'Sensor_Azimuth',
        description: 'Sensor azimuth angle',
        'gee:units': units.degree
      },
      {
        name: 'Sensor_Zenith',
        description: 'Sensor zenith angle',
        'gee:units': units.degree
      },
      {
        name: 'Solar_Azimuth',
        description: 'Solar azimuth angle',
        'gee:units': units.degree
      },
      {
        name: 'Solar_Zenith',
        description: 'Solar zenith angle',
        'gee:units': units.degree
      },
      {
        name: 'UTC_Time',
        description: 'UTC time',
        'gee:units': units.hour
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Day-Night Band (DNB) at sensor radiance 500m',
        lookat: {lat: -79.4, lon: 43.1, zoom: 8},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            bands: ['DNB_At_Sensor_Radiance_500m'],
          },
        },
      },
    ],
    BrightnessTemperature_M12: {
      minimum: 0.0,
      maximum: 163.835,
      'gee:estimated_range': false,
    },
    BrightnessTemperature_M13: {
      minimum: 0.0,
      maximum: 163.835,
      'gee:estimated_range': false,
    },
    BrightnessTemperature_M15: {
      minimum: 0.0,
      maximum: 163.835,
      'gee:estimated_range': false,
    },
    BrightnessTemperature_M16: {
      minimum: 0.0,
      maximum: 163.835,
      'gee:estimated_range': false,
    },
    DNB_At_Sensor_Radiance_500m: {
      minimum: 0.0,
      maximum: 6553.4,
      'gee:estimated_range': false,
    },
    Glint_Angle: {
      minimum: -180,
      maximum: 180,
      'gee:estimated_range': false,
    },
    Granule: {
      minimum: 0,
      maximum: 254,
      'gee:estimated_range': false,
    },
    Lunar_Zenith: {
      minimum: 0,
      maximum: 180,
      'gee:estimated_range': false,
    },
    Lunar_Azimuth: {
      minimum: -180,
      maximum: 180,
      'gee:estimated_range': false,
    },
    Moon_Illumination_Fraction: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    Moon_Phase_Angle: {
      minimum: 0,
      maximum: 180,
      'gee:estimated_range': false,
    },
    QF_Cloud_Mask: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_DNB: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M10: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M11: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M12: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M13: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M15: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    QF_VIIRS_M16: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
    Radiance_M10: {
      minimum: 0,
      maximum: 85.1942,
      'gee:estimated_range': false,
    },
    Radiance_M11: {
      minimum: 0,
      maximum: 38.00972,
      'gee:estimated_range': false,
    },
    Sensor_Azimuth: {
      minimum: -180,
      maximum: 180,
      'gee:estimated_range': false,
    },
    Sensor_Zenith: {
      minimum: 0,
      maximum: 90,
      'gee:estimated_range': false,
    },
    Solar_Azimuth: {
      minimum: -180,
      maximum: 180,
      'gee:estimated_range': false,
    },
    Solar_Zenith: {
      minimum: 0,
      maximum: 180,
      'gee:estimated_range': false,
    },
    UTC_Time: {
      minimum: 0,
      maximum: 24,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VNP46A1.001',
  'sci:citation': "Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)",
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
