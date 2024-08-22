local id = 'NOAA/VIIRS/001/VNP09H1';
local subdir = 'NOAA';
local successor_id = 'NASA/VIIRS/002/VNP09H1';
local latest_id = successor_id;
local version = 'v001';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
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
  title: 'VNP09H1: VIIRS Surface Reflectance 8-Day L3 Global 500m [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The 8-day Visible Infrared Imaging Radiometer Suite (VIIRS) Surface
    Reflectance (VNP09H1) Version 1 composite product provides an estimate of
    land surface reflectance from the Suomi National Polar-orbiting Partnership
    (Suomi NPP) VIIRS sensor for three imagery bands (I1, I2, I3) at nominal
    500m resolution (~463m). The 500m dataset is derived through resampling the
    native 375m VIIRS resolution in the L2 input product. The data are corrected
    for atmospheric conditions such as the effects of molecular gases, including
    ozone and water vapor, and for the effects of atmospheric aerosols. Each
    pixel represents the best possible Level 2G observation during an 8-day
    period, which is selected on the basis of high observation coverage, low
    sensor angle, the absence of clouds or cloud shadow, and aerosol loading.
    The three reflectance bands, this product includes a state quality assurance
    (QA) layer and a reflectance band quality layer.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/123/VNP09_User_Guide_V1.1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/122/VNP09_ATBD.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp09h1v001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP09H1.001',
    },
    ee.link.latest(
      latest_id,
      ee_const.catalog_base + 'NASA/' + latest_basename + '.json'),
    ee.link.successor(
      successor_id,
      ee_const.catalog_base + 'NASA/' + successor_basename + '.json'),
  ],
  keywords: [
    'daily',
    'nasa',
    'noaa',
    'npp',
    'reflectance',
    'sr',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP09H1.001'),
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
        name: 'SurfReflect_I1',
        description: '500 m Surface Reflectance Band I1',
      },
      {
        name: 'SurfReflect_I2',
        description: '500 m Surface Reflectance Band I2',
      },
      {
        name: 'SurfReflect_I3',
        description: '500 m Surface Reflectance Band I3',
      },
      {
        name: 'SurfReflect_QC_500m',
        description: 'Surface Reflectance Band Quality Control (QC)',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QA bits',
              bit_count: 2,
              values: [
                {
                  description: |||
                    Corrected product produced at ideal quality all bands
                  |||,
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Corrected product produced at less than ideal quality some
                    or all bands
                  |||,
                },
                {
                  value: 2,
                  description: |||
                    Corrected product not produced due to cloud effects all
                    bands
                  |||,
                },
                {
                  value: 3,
                  description: |||
                    Corrected product not produced due to other reasons some or
                    all bands may be fill value [Note that a value of (11)
                    overrides a value of (01)].
                  |||,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud State',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
                {
                  value: 2,
                  description: 'Mixed',
                },
                {
                  value: 3,
                  description: 'Not set, assumed clear',
                },
              ],
            },
            {
              description: 'Band 1 data quality four bit range',
              first_bit: 4,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Noisy detector',
                },
                {
                  value: 2,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 3,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 4,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 5,
                  description: 'Missing input',
                },
                {
                  value: 6,
                  description: |||
                    Internal constant used in place of climatological data for
                    at least one atmospheric constant
                  |||,
                },
                {
                  value: 7,
                  description: |||
                    Correction out of bounds, pixel constrained to extreme
                    allowable value
                  |||,
                },
                {
                  value: 8,
                  description: 'L1B data faulty',
                },
                {
                  value: 9,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Band 2 data quality four bit range',
              first_bit: 8,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Noisy detector',
                },
                {
                  value: 2,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 3,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 4,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 5,
                  description: 'Missing input',
                },
                {
                  value: 6,
                  description: |||
                    Internal constant used in place of climatological data for
                    at least one atmospheric constant
                  |||,
                },
                {
                  value: 7,
                  description: |||
                    Correction out of bounds, pixel constrained to extreme
                    allowable value
                  |||,
                },
                {
                  value: 8,
                  description: 'L1B data faulty',
                },
                {
                  value: 9,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Atmospheric correction performed',
              first_bit: 12,
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
              description: 'Adjacency correction performed',
              first_bit: 13,
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
              description: 'Different orbit from 500m',
              first_bit: 14,
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
          total_bit_count: 15,
        },
      },
      {
        name: 'SurfReflect_State_500m',
        description: 'Surface Reflectance State Quality Assurance (QA)',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud state',
              bit_count: 2,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
                {
                  value: 2,
                  description: 'Mixed',
                },
                {
                  value: 3,
                  description: 'Not set, assumed clear',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud shadow',
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
              description: 'Land/water flag',
              first_bit: 3,
              bit_count: 3,
              values: [
                {
                  description: 'Shallow ocean',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land',
                },
                {
                  value: 2,
                  description: 'Ocean coastlines and lake shorelines',
                },
                {
                  value: 3,
                  description: 'Shallow inland water',
                },
                {
                  value: 4,
                  description: 'Ephemeral water',
                },
                {
                  value: 5,
                  description: 'Deep inland water',
                },
                {
                  value: 6,
                  description: 'Continental/moderate ocean',
                },
                {
                  value: 7,
                  description: 'Deep ocean',
                },
              ],
            },
            {
              description: 'Aerosol quantity',
              first_bit: 6,
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
              description: 'Cirrus detected',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Small',
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
              description: 'Cloud shadow',
              first_bit: 10,
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
              description: 'Internal fire algorithm flag',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'No Fire',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Fire',
                },
              ],
            },
            {
              description: 'Snow/ice flag',
              first_bit: 12,
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
              description: 'Pixel is adjacent to cloud',
              first_bit: 13,
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
              description: 'BRDF correction performed',
              first_bit: 14,
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
              description: 'Internal snow flag',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'No snow',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
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
              3000.0,
            ],
            bands: [
              'SurfReflect_I1',
              'SurfReflect_I2',
              'SurfReflect_I3',
            ],
          },
        },
      },
    ],
    SurfReflect_I1: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    SurfReflect_I2: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    SurfReflect_I3: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    SurfReflect_State_500m: {
      minimum: 0,
      maximum: 13311.0,
      'gee:estimated_range': false,
    },
    SurfReflect_QC_500m: {
      minimum: 0,
      maximum: 13311.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VNP09H1.001',
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
