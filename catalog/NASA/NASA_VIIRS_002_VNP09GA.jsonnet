local id = 'NASA/VIIRS/002/VNP09GA';
local version = 'v002';
local predecessor_id = 'NOAA/VIIRS/001/VNP09GA';
local latest_id = id;
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VNP09GA: VIIRS Surface Reflectance Daily 500m and 1km',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Visible Infrared Imaging Radiometer Suite (VIIRS) daily surface
    reflectance (VNP09GA) product provides an estimate of land
    surface reflectance from the Suomi National Polar-Orbiting Partnership
    (S-NPP) VIIRS sensor. Data are provided for three imagery bands
    (I1, I2, I3) at nominal 500 meter resolution (~463 meter) and nine
    moderate-resolution bands (M1, M2, M3, M4, M5, M7, M8, M10, M11) at nominal
    1 kilometer (~926 meter) resolution. The 500 meter and 1 kilometer datasets
    are derived through resampling the native 375 meter and 750 meter VIIRS
    resolutions, respectively, in the L2 input product. These bands are
    corrected for atmospheric conditions to provide an estimate
    of the surface spectral reflectance as it would be measured at ground level.

    The data is temporally aggregated over each of the 16 possible passes per
    day. When multiple observations are present for each day, only the first
    of the highest-quality observations is included.

    The band scale factors are already applied.

    For additional information, visit the VIIRS [Land Product Quality
    Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)

    Documentation:

    * [User's Guide] (https://lpdaac.usgs.gov/documents/1657/VNP09_User_Guide_V2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)] (https://lpdaac.usgs.gov/documents/122/VNP09_ATBD.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP09GA.002',
    },
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
    ee.link.predecessor(
      predecessor_id,
      ee_const.catalog_base + 'NOAA/' + predecessor_basename + '.json'),
  ],
  keywords: [
    'daily',
    'nasa',
    'noaa',
    'npp',
    'reflectance',
    'sr',
    'viirs',
    'vnp09ga',
  ],
  providers: [
    ee.producer_provider('NASA Land SIPS', 'https://doi.org/10.5067/VIIRS/VNP09GA.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2631841556-LPCLOUD',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: {
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'M1',
        description: '1km surface reflectance band M1',
        center_wavelength: 0.412,
        gsd: 1000.0,
        'gee:wavelength': '0.402 - 0.422&micro;m',
      },
      {
        name: 'M2',
        description: '1km surface reflectance Band M2',
        center_wavelength: 0.445,
        gsd: 1000.0,
        'gee:wavelength': '0.436 - 0.454&micro;m',
      },
      {
        name: 'M3',
        description: '1km surface reflectance band M3',
        center_wavelength: 0.483,
        gsd: 1000.0,
        'gee:wavelength': '0.478 - 0.488&micro;m',
      },
      {
        name: 'M4',
        description: '1km surface reflectance band M4',
        center_wavelength: 0.555,
        gsd: 1000.0,
        'gee:wavelength': '0.545 - 0.565&micro;m',
      },
      {
        name: 'M5',
        description: '1km surface reflectance band M5',
        center_wavelength: 0.672,
        gsd: 1000.0,
        'gee:wavelength': '0.662 - 0.682&micro;m',
      },
      {
        name: 'M7',
        description: '1km surface reflectance band M7',
        center_wavelength: 0.866,
        gsd: 1000.0,
        'gee:wavelength': '0.846 - 0.885&micro;m',
      },
      {
        name: 'M8',
        description: '1km surface reflectance band M8',
        center_wavelength: 1.24,
        gsd: 1000.0,
        'gee:wavelength': '1.230 - 1.250&micro;m',
      },
      {
        name: 'M10',
        description: '1km surface reflectance band M10',
        center_wavelength: 1.61,
        gsd: 1000.0,
        'gee:wavelength': '1.580 - 1.640&micro;m',
      },
      {
        name: 'M11',
        description: '1km surface reflectance band M11',
        center_wavelength: 2.25,
        gsd: 1000.0,
        'gee:wavelength': '2.230 - 2.280&micro;m',
      },
      {
        name: 'I1',
        description: '500m surface reflectance band I1',
        center_wavelength: 0.64,
        gsd: 500.0,
        'gee:wavelength': '0.600 - 0.680&micro;m',
      },
      {
        name: 'I2',
        description: '500m surface reflectance band I2',
        center_wavelength: 0.865,
        gsd: 500.0,
        'gee:wavelength': '0.850 - 0.880&micro;m',
      },
      {
        name: 'I3',
        description: '500m surface reflectance band I3',
        center_wavelength: 1.61,
        gsd: 500.0,
        'gee:wavelength': '1.580 - 1.640&micro;m',
      },
      {
        name: 'SensorAzimuth',
        description: 'Sensor azimuth angle',
        'gee:units': units.degree,
        gsd: 1000.0,
      },
      {
        name: 'SensorZenith',
        description: 'Sensor zenith angle',
        'gee:units': units.degree,
        gsd: 1000.0,
      },
      {
        name: 'SolarAzimuth',
        description: 'Solar azimuth angle',
        'gee:units': units.degree,
        gsd: 1000.0,
      },
      {
        name: 'SolarZenith',
        description: 'Solar zenith angle',
        'gee:units': units.degree,
        gsd: 1000.0,
      },
      {
        name: 'iobs_res',
        description: 'Observation number',
        gsd: 500.0,
      },
      {
        name: 'num_observations_1km',
        description: 'Number of observations 1km',
        gsd: 1000.0,
      },
      {
        name: 'num_observations_500m',
        description: 'Number of observations 500m',
        gsd: 500.0,
      },
      {
        name: 'obscov_1km',
        description: 'Observations coverage 1km',
        'gee:units': units.percent,
        gsd: 1000.0,
      },
      {
        name: 'obscov_500m',
        description: 'Observations coverage 500km',
        'gee:units': units.percent,
        gsd: 500.0,
      },
      {
        name: 'orbit_pnt',
        description: 'Orbit pointer',
        gsd: 1000.0,
      },
      {
        name: 'QF1',
        description: 'Quality flags 1',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud mask quality',
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
              first_bit: 0,
            },
            {
              description: 'Cloud detection & confidence',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Confident clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Probably clear',
                },
                {
                  value: 2,
                  description: 'Probably cloudy',
                },
                {
                  value: 3,
                  description: 'Confident cloudy',
                },
              ],
            },
            {
              description: 'Day/night',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Day',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night',
                },
              ],
            },
            {
              description: 'Low sun mask',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'High',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
              ],
            },
            {
              description: 'Sun glint',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Geometry based',
                },
                {
                  value: 2,
                  description: 'Wind speed based',
                },
                {
                  value: 3,
                  description: 'Geometry and wind speed based',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QF2',
        description: 'Quality flags 2',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land/water background',
              bit_count: 3,
              values: [
                {
                  description: 'Land & desert',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land no desert',
                },
                {
                  value: 2,
                  description: 'Inland water',
                },
                {
                  value: 3,
                  description: 'Sea water',
                },
                {
                  value: 4,
                  description: '---',
                },
                {
                  value: 5,
                  description: 'Coastal',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Shadow mask',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'No cloud shadow',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Shadow',
                },
              ],
            },
            {
              description: 'Heavy aerosol mask',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'No heavy aerosol',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Heavy aerosol',
                },
              ],
            },
            {
              description: 'Snow/ice',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No snow/ice',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow or ice',
                },
              ],
            },
            {
              description: 'Thin cirrus reflective',
              first_bit: 6,
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
              description: 'This cirrus emissive',
              first_bit: 7,
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
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QF3',
        description: 'Quality flags 3',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Bad M1 SDR data',
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
              first_bit: 0,
            },
            {
              description: 'Bad M2 SDR data',
              first_bit: 1,
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
              description: 'Bad M3 SDR data',
              first_bit: 2,
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
              description: 'Bad M4 SDR data',
              first_bit: 3,
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
              description: 'Bad M5 SDR data',
              first_bit: 4,
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
              description: 'Bad M7 SDR data',
              first_bit: 5,
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
              description: 'Bad M8 SDR data',
              first_bit: 6,
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
              description: 'Bad M10 SDR data',
              first_bit: 7,
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
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QF4',
        description: 'Quality flags 4',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Bad M11 SDR data',
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
              first_bit: 0,
            },
            {
              description: 'Bad I1 SDR data',
              first_bit: 1,
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
              description: 'Bad I2 SDR data',
              first_bit: 2,
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
              description: 'Bad I3 SDR data',
              first_bit: 3,
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
              description: 'Overall quality of AOT',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Missing AOT input data',
              first_bit: 5,
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
              description: 'Invalid land AM input data',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Invalid AM input over land or over ocean',
                },
              ],
            },
            {
              description: 'Missing PW input data',
              first_bit: 7,
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
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QF5',
        description: 'Quality flags 5',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Missing ozone input data',
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
              first_bit: 0,
            },
            {
              description: 'Missing surface pressure input data',
              first_bit: 1,
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
              description: 'Overall quality M1 surface reflection data',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M2 surface reflection data',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M3 surface reflection data',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M4 surface reflection data',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M5 surface reflection data',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M7 surface reflection data',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'QF6',
        description: 'Quality flags 6',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Overall quality M8 surface reflection data',
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Overall quality M10 surface reflection data',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality M11 surface reflection data',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality I1 surface reflection data',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality I2 surface reflection data',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'Overall quality I3 surface reflection data',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
          ],
          total_bit_count: 6,
        },
      },
      {
        name: 'QF7',
        description: 'Quality flags 7',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Snow present',
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
              first_bit: 0,
            },
            {
              description: 'Adjacent to cloud',
              first_bit: 1,
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
              description: 'Aerosol quantity',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Average',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Thin cirrus flag',
              first_bit: 4,
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
          ],
          total_bit_count: 5,
        },
      },
      {
        name: 'land_water_mask',
        description: 'Land/water mask.',
        gsd: 1000.0,
        'gee:classes': [
          {value: 0, color: '0000ff', description: 'Shallow_Ocean'},
          {value: 1, color: '008000', description: 'Land'},
          {value: 2, color: 'ffff00', description: 'Coastline'},
          {value: 3, color: '808000', description: 'Shallow_Inland'},
          {value: 4, color: '00ffff', description: 'Ephemeral'},
          {value: 5, color: '800000', description: 'Deep_Inland'},
          {value: 6, color: 'ff0000', description: 'Continental'},
          {value: 7, color: '000080', description: 'Deep_Ocean'}
        ]
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.3,
            ],
            bands: [
              'M5',
              'M4',
              'M3',
            ],
          },
        },
      },
    ],
    M1: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M2: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M3: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M4: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M5: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M7: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M8: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M10: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    M11: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    I1: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    I2: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    I3: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    SensorAzimuth: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    SensorZenith: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    SolarAzimuth: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    SolarZenith: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    iobs_res: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    num_observations_1km: {
      minimum: 0.0,
      maximum: 127.0,
      'gee:estimated_range': false,
    },
    num_observations_500m: {
      minimum: 0.0,
      maximum: 127.0,
      'gee:estimated_range': false,
    },
    obscov_1km: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    obscov_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    orbit_pnt: {
      minimum: 0.0,
      maximum: 15.0,
      'gee:estimated_range': false,
    },
    land_water_mask: {
      minimum: 0.0,
      maximum: 7.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VNP09GA.002',
  'sci:citation': |||
      Vermote, E., Franch, B., Claverie, M. (2023). VIIRS/NPP Surface Reflectance Daily L2G Global 1km and 500m SIN Grid V002 [Data set]. NASA EOSDIS Land Processes Distributed Active Archive Center.
   |||,
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
