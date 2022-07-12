local id = 'LANDSAT/LT05/C01/T1_8DAY_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Landsat 5 TM Collection 1 Tier 1 8-Day TOA Reflectance Composite',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 5 TM Collection 1 Tier 1 composites are made from Tier 1 orthorectified scenes, using the
      computed top-of-atmosphere (TOA) reflectance.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.

    These composites are created from
    all the scenes in each
    8-day period beginning from the first day of the year and continuing
    to the 360th day of the year.  The last composite of the year,
    beginning on day 361, will overlap the first composite of the
    following year by 3 days.  All the images from each 8-day period are
    included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-01-01T00:00:00Z', '2012-04-30T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.76 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B6',
        description: 'Thermal Infrared 1. Resampled from 60m to 30m.',
        center_wavelength: 11.45,
        gsd: 30.0,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
      {
        name: 'BQA',
        description: |||
          Landsat Collection 1 QA Bitmask ([See Landsat QA page](https://www.usgs.gov/land-resources/nli/landsat/landsat-collection-1-level-1-quality-assessment-band))
        |||,
        gsd: 30.0,
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
            gamma: [
              1.2,
            ],
            gain: [
              600.0,
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
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
  'gee:interval': {type: 'cadence', unit: 'day', interval: 8},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
}
