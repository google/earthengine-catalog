local id = 'LANDSAT/LT4_L1T_32DAY_RAW';
local successor_id = 'LANDSAT/LT04/C01/T1_32DAY_RAW';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Landsat 4 TM 32-Day Raw Composite [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 4 TM composites are made from Level L1T orthorectified scenes, using the DN values, representing scaled, calibrated at-sensor radiance.

    As of May 1, 2017, the USGS is no longer producing Pre-Collection Landsat, and therefore this collection is complete. Please switch to a Collection 1-based dataset. See [this documentation page](https://developers.google.com/earth-engine/landsat) for more information.

    These composites are created from
    all the scenes in
    each 32-day period beginning from the first day of the year and
    continuing to the 352nd day of the year.  The last composite of the
    year, beginning on day 353, will overlap the first composite of the
    following year by 20 days.  All the images from each 32-day period are
    included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'landsat',
    'raw',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1982-08-13T00:00:00Z', '1993-11-17T00:00:00Z'),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        'gee:wavelength': '0.76 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B6',
        description: 'Thermal Infrared 1. Resampled from 60m to 30m.',
        center_wavelength: 11.45,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
      {
        name: 'BQA',
        description: |||
          Landsat Collection 1 QA Bitmask ([See Landsat QA page](https://www.usgs.gov/land-resources/nli/landsat/landsat-collection-1-level-1-quality-assessment-band))
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Designated Fill',
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
              description: 'Designated Pixel',
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
              description: 'Radiometric Saturation',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'No bands contain saturation',
                  value: 0,
                },
                {
                  value: 1,
                  description: '1-2 bands contain saturation',
                },
                {
                  value: 2,
                  description: '3-4 bands contain saturation',
                },
                {
                  value: 3,
                  description: '5 or more bands contain saturation',
                },
              ],
            },
            {
              description: 'Cloud',
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
              description: 'Cloud Confidence',
              first_bit: 5,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
            {
              description: 'Cloud Shadow Confidence',
              first_bit: 7,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
            {
              description: 'Snow / Ice Confidence',
              first_bit: 9,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
          ],
          total_bit_count: 11,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (432)',
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.4,
            ],
            bands: [
              'B4',
              'B3',
              'B2',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (742)',
        image_visualization: {
          band_vis: {
            gain: [
              1.8,
              1.9,
              1.9,
            ],
            bands: [
              'B7',
              'B4',
              'B2',
            ],
          },
        },
      },
    ],
  },
  'gee:min_zoom_level': 4,
  'gee:interval': {type: 'cadence', unit: 'day', interval: 32},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
  version: ee_const.version_unknown,
}
