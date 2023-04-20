local id = 'TIGER/2020/TABBLOCK20';
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
  title: 'TIGER: 2020 Tabulation (Census) Block ',
  version: '2020',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau regularly releases
    a geodatabase named TIGER. This dataset contains the 2020 census
    blocks, roughly equivalent to a city block. There are just over
    eight million polygon features covering the United States, the District
    of Columbia, Puerto Rico, and the
    [Island areas](https://www.census.gov/programs-surveys/decennial-census/decade/2020/planning-management/release/2020-island-areas-data-products.html).

    For full technical details on all TIGER 2020 products, see the
    [TIGER technical documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2020/TGRSHP2020_TechDoc.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
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
                    '2020-01-01T00:00:00Z', '2020-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ALAND20',
        description: '2020 Census land area',
        type: ee_const.var_type.double,
      },
      {
        name: 'AWATER20',
        description: '2020 Census water area',
        type: ee_const.var_type.double,
      },
      {
        name: 'BLOCKCE20',
        description: '2020 Census tabulation block number',
        type: ee_const.var_type.string,
      },
      {
        name: 'COUNTYFP20',
        description: '2020 Census county FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'FUNCSTAT20',
        description: '2020 Census functional status',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOID20',
        description: |||
          Census block identifier: a concatenation of 2020
          Census state FIPS code, 2020 Census county FIPS
          code, 2020 Census tract code, and 2020 Census
          block number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLAT20',
        description: '2020 Census latitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLON20',
        description: '2020 Census longitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'MTFCC20',
        description: 'MAF/TIGER feature class code',
        type: ee_const.var_type.string,
      },
      {
        name: 'NAME20',
        description: |||
          2020 Census tabulation block name: a concatenation
          of Block and the tabulation block number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'STATEFP20',
        description: '2020 Census state FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'TRACTCE20',
        description: '2020 Census tract code',
        type: ee_const.var_type.string,
      },
      {
        name: 'UACE20',
        description: '2020 Census urban area code',
        type: ee_const.var_type.string,
      },
      {
        name: 'UATYPE20',
        description: '2020 Census urban area type',
        type: ee_const.var_type.string,
      },
      {
        name: 'UR20',
        description: '2020 Census urban/rural indicator',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water area 2020',
        lookat: {
          lat: 40.9,
          lon: -73.15,
          zoom: 9,
        },
        polygon_visualization: {
          property_name: 'AWATER20',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              1e7
            ],
            palette: ['d8d9d9', 'aaaaaa', 'b6dfe9', '2ea3f2', '0c71c3'],
          },
        },
      },
      {
        display_name: 'Water area 2020',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 40.9,
          lon: -73.15,
          zoom: 9,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['STATEFP20 ASC'],
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
