local id = 'TIGER/2010/Blocks';
local subdir = 'TIGER';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census Blocks',
  version: '2010',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau regularly releases
    a geodatabase named TIGER. This dataset contains the 2010 census
    blocks, roughly equivalent to a city block. There are just over
    11 million polygon features covering the United States, the District
    of Columbia, Puerto Rico, and the
    [Island areas](https://www.census.gov/data/tables/2010/dec/2010-island-areas.html).

    For full technical details on all TIGER 2010 products, see the
    [TIGER technical documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2010/TGRSHP10SF1.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'census',
    'city',
    'neighborhood',
    'tiger',
    'urban',
    'us',
  ],
  providers: [
    ee.producer_provider('United States Census Bureau', 'https://www.census.gov/programs-surveys/geography/guidance/tiger-data-products-guide.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, -64.435, 71.567,
                    '2010-01-01T00:00:00Z', '2010-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'blockce',
        description: '2010 Census tabulation block number',
        type: ee_const.var_type.string,
      },
      {
        name: 'blockid10',
        description: |||
          Block identifier: a concatenation of 2010 Census
          state Federal Information Processing Standards (FIPS) code, county
          FIPS code, census tract code, and tabulation block number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'countyfp10',
        description: 'County FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'housing10',
        description: '2010 Census number of housing units',
        type: ee_const.var_type.double,
      },
      {
        name: 'partflg',
        description: 'Partial block flag',
        type: ee_const.var_type.string,
      },
      {
        name: 'pop10',
        description: 'Population total as of 2010 census',
        type: ee_const.var_type.double,
      },
      {
        name: 'statefp10',
        description: '2010 Census state FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'tractce10',
        description: '2010 Census tract code',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population 2010',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 13,
        },
        polygon_visualization: {
          property_name: 'pop10',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              19352.0,
            ],
            gamma: [
              7.0,
            ],
          },
        },
      },
      {
        display_name: 'Population 2010',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 13,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['statefp10 ASC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    For the creation of any reports, publications, new data sets, derived
    products, or services resulting from the data set, users should
    [cite the US Census Bureau](https://www.census.gov/about/policies/citation.html).
  |||,
  'gee:terms_of_use': |||
    The U.S. Census Bureau offers some of its public data
    in machine-readable format via an Application Programming Interface
    (API). All of the content, documentation, code and related materials
    made available to you through the API are subject to [these terms and
    conditions](https://www.census.gov/data/developers/about/terms-of-service.html).
  |||,
}
