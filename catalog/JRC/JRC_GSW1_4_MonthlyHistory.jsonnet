local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'JRC_GSW_MonthlyHistory_version_map.libsonnet';

local subdir = 'JRC';
local id = 'JRC/GSW1_4/MonthlyHistory';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'JRC Monthly Water History, v1.4',
  version: '1.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: (importstr 'JRC_GSW_1_4_description.md') + |||
    This Monthly History collection holds the entire history of water detection
    on a month-by-month basis. The collection contains 454 images, one for each
    month between March 1984 and December 2021.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) +
  version_config.version_links,
  keywords: [
    'geophysical',
    'google',
    'history',
    'jrc',
    'landsat_derived',
    'monthly',
    'surface',
    'water',
  ],
  providers: [
    ee.producer_provider('EC JRC / Google', 'https://global-surface-water.appspot.com'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -59.0, 180.0, 78.0,
                    '1984-03-16T00:00:00Z', '2022-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'month',
        description: 'Month',
        type: ee_const.var_type.double,
      },
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'water',
        description: 'Water detection for the month.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Water detection',
              bit_count: 2,
              values: [
                {
                  description: 'No data',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Not water',
                },
                {
                  value: 2,
                  description: 'Water',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water',
        lookat: {
          lat: 38.109,
          lon: -121.234,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              2.0,
            ],
            palette: [
              'ffffff',
              'fffcb8',
              '0905ff',
            ],
            bands: [
              'water',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Jean-Francois Pekel, Andrew Cottam, Noel Gorelick, Alan S. Belward,
    High-resolution mapping of global surface water and its long-term changes.
    Nature 540, 418-422 (2016). ([doi:10.1038/nature20584](https://doi.org/10.1038/nature20584))
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    All data here is produced under the Copernicus Programme and is provided
    free of charge, without restriction of use. For the full license
    information see the Copernicus Regulation.

    Publications, models, and data products that make use of these datasets
    must include proper acknowledgement, including citing datasets and the
    journal article as in the following citation.

    If you are using the data as a layer in a published map, please include the
    following attribution text: 'Source: EC JRC/Google'
  |||,
  'gee:user_uploaded': true,
}
