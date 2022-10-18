local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'JRC_GSW_GlobalSurfaceWater_version_map.libsonnet';

local subdir = 'JRC';
local version = 'v1.4';
local version_config = versions(subdir, version_table, version);

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: version_config.id,
  title: 'JRC Global Surface Water Mapping Layers, v1.4',
  version: '1.4',
  'gee:type': ee_const.gee_type.image,
  description: (importstr 'JRC_GSW_1_4_description.md') + |||
    This mapping layers product consists of 1 image containing 7 bands.
    It maps different facets of the spatial and temporal distribution of
    surface water over the last 38 years. Areas where water has
    never been detected are masked.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, version_config.id) +
  version_config.version_links,
  keywords: [
    'geophysical',
    'google',
    'jrc',
    'landsat_derived',
    'surface',
    'water',
  ],
  providers: [
    ee.producer_provider('EC JRC / Google', 'https://global-surface-water.appspot.com'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1984-03-16T00:00:00Z', '2022-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'occurrence',
        description: 'The frequency with which water was present.',
        'gee:units': '%',
      },
      {
        name: 'change_abs',
        description: 'Absolute change in occurrence between two epochs: 1984-1999 vs 2000-2021.',
        'gee:units': '%',
      },
      {
        name: 'change_norm',
        description: 'Normalized change in occurrence. (epoch1-epoch2)/(epoch1+epoch2) * 100',
        'gee:units': '%',
      },
      {
        name: 'seasonality',
        description: 'Number of months water is present.',
      },
      {
        name: 'recurrence',
        description: 'The frequency with which water returns from year to year.',
        'gee:units': '%',
      },
      {
        name: 'transition',
        description: 'Categorical classification of change between first and last year.',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'No change',
            value: 0,
          },
          {
            value: 1,
            color: '0000ff',
            description: 'Permanent',
          },
          {
            value: 2,
            color: '22b14c',
            description: 'New permanent',
          },
          {
            value: 3,
            color: 'd1102d',
            description: 'Lost permanent',
          },
          {
            value: 4,
            color: '99d9ea',
            description: 'Seasonal',
          },
          {
            value: 5,
            color: 'b5e61d',
            description: 'New seasonal',
          },
          {
            value: 6,
            color: 'e6a1aa',
            description: 'Lost seasonal',
          },
          {
            value: 7,
            color: 'ff7f27',
            description: 'Seasonal to permanent',
          },
          {
            value: 8,
            color: 'ffc90e',
            description: 'Permanent to seasonal',
          },
          {
            value: 9,
            color: '7f7f7f',
            description: 'Ephemeral permanent',
          },
          {
            value: 10,
            color: 'c3c3c3',
            description: 'Ephemeral seasonal',
          },
        ],
      },
      {
        name: 'max_extent',
        description: 'Binary image containing 1 anywhere water has ever been detected.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Flag indicating if water was detected or not',
              bit_count: 1,
              values: [
                {
                  description: 'Not water',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Water',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Occurrence',
        lookat: {
          lat: 45.182,
          lon: 59.414,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'ffffff',
              'ffbbbb',
              '0000ff',
            ],
            bands: [
              'occurrence',
            ],
          },
        },
      },
    ],
    occurrence: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    change_abs: {
      minimum: -100.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    change_norm: {
      minimum: -100.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    seasonality: {
      minimum: 0.0,
      maximum: 12.0,
      'gee:estimated_range': false,
    },
    recurrence: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Jean-Francois Pekel, Andrew Cottam, Noel Gorelick, Alan S. Belward,
    High-resolution mapping of global surface water and its long-term changes.
    Nature 540, 418-422 (2016). ([doi:10.1038/nature20584](https://doi.org/10.1038/nature20584))
  |||,
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
