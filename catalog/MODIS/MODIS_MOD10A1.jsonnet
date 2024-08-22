local id = 'MODIS/MOD10A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD10A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
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
  title: 'MOD10A1.005 Terra Snow Cover Daily Global 500m [deprecated]',
  version: '5',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD10A1 V5 Snow Cover Daily Global 500m product
    contains snow cover, snow albedo, fractional snow cover, and quality
    assessment (QA) data. Snow cover data are based on a snow mapping
    algorithm that employs a Normalized Difference Snow Index (NDSI)
    and other criteria tests.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/63NQASRDPDB0',
    },
  ] + version_config.version_links,
  keywords: [
    'albedo',
    'daily',
    'geophysical',
    'global',
    'mod10a1',
    'modis',
    'nsidc',
    'snow',
    'terra',
  ],
  providers: [
    ee.producer_provider('NSIDC', 'https://nsidc.org/data/MOD10A1/versions/5'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C92711294-NSIDC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', '2016-12-26T00:00:00Z'),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'Terra',
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Snow_Cover_Daily_Tile',
        description: |||
          NDSI snow cover plus other results. This value is
          computed for MOD10_L2 and retrieved when the observation of
          the day is selected. Possible values are: 0-100 (NDSI snow cover).
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Snow Cover',
              bit_count: 8,
              values: [
                {
                  description: 'Data missing',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'No decision',
                },
                {
                  value: 11,
                  description: 'Darkness, terminator, or polar night',
                },
                {
                  value: 25,
                  description: 'Snow-free land',
                },
                {
                  value: 37,
                  description: 'Lake or inland water',
                },
                {
                  value: 39,
                  description: 'Open water',
                },
                {
                  value: 50,
                  description: 'Cloud obscured',
                },
                {
                  value: 100,
                  description: 'Snow-covered lake ice',
                },
                {
                  value: 200,
                  description: 'Snow-covered land',
                },
                {
                  value: 254,
                  description: 'Detector saturated',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Snow_Spatial_QA',
        description: |||
          A basic estimate of the quality of the algorithm result.
          This value is computed for MOD10_L2 and retrieved with the corresponding
          observation of the day.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'QA',
              bit_count: 8,
              values: [
                {
                  description: 'Good quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality',
                },
                {
                  value: 252,
                  description: 'Antarctica mask',
                },
                {
                  value: 253,
                  description: 'Land mask',
                },
                {
                  value: 254,
                  description: 'Ocean mask',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Snow_Albedo_Daily_Tile',
        description: 'Snow albedo percentage plus other results.',
      },
      {
        name: 'Fractional_Snow_Cover',
        description: 'Snow cover percentage plus other results.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Snow Cover',
        lookat: {
          lat: 76.35,
          lon: -41.13,
          zoom: 3,
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
              '000000',
              '0dffff',
              '0524ff',
              'ffffff',
            ],
            bands: [
              'Snow_Cover_Daily_Tile',
            ],
          },
        },
      },
    ],
    Snow_Albedo_Daily_Tile: {
      minimum: 1.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    Fractional_Snow_Cover: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/63NQASRDPDB0',
  'sci:citation': |||
    Hall, D. K., V. V. Salomonson, and G. A. Riggs. 2006. MODIS/Terra
    Snow Cover Daily L3 Global 500m Grid. Version 5. Boulder, Colorado
    USA: NASA National Snow and Ice Data Center Distributed Active
    Archive Center.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    You may download and use photographs, imagery, or text
    from the NSIDC web site, unless limitations for its use are specifically
    stated. For more information on usage and citing NSIDC datasets,
    please visit the [NSIDC 'Use and Copyright' page](https://nsidc.org/about/data-use-and-copyright).
  |||,
}
