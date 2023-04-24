local id = 'TIGER/2020/BG';
local subdir = 'TIGER';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census Block Groups (BG) 2020',
  version: '2020',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau regularly releases
    a geodatabase named TIGER. This dataset contains the 2020 census
    [block groups](https://www.census.gov/programs-surveys/geography/about/glossary.html#par_textimage_4),
    which is a cluster of blocks within the same census tract that have the same
    first digit of their four-digit census block number. There are just over
    240,000 polygon features covering the United States, the District
    of Columbia, Puerto Rico, and the
    Island areas.

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
  extent: ee.extent(-180.0,
                    -14.69,
                    -64.435,
                    71.567,
                    '2020-01-01T00:00:00Z',
                    '2020-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ALAND',
        description: 'Land Area (square meters)',
        type: ee_const.var_type.double,
        units: units.square_m,
      },
      {
        name: 'AWATER',
        description: 'Water Area (square meters)',
        type: ee_const.var_type.double,
        units: units.square_m,
      },
      {
        name: 'BLKGRPCE',
        description: 'Block Group Code',
        type: ee_const.var_type.string,
      },
      {
        name: 'COUNTYFP',
        description: 'County FIPS Code',
        type: ee_const.var_type.string,
      },
      {
        name: 'FUNCSTAT',
        description: 'Functional Status (S = Statistical)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOID',
        description: |||
          Unique Identifier of Summary Level, Characteristic
          Iteration, US, State, County, Tract, Block Group Code
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLAT',
        description: 'Internal Point Latitude',
        type: ee_const.var_type.double,
      },
      {
        name: 'INTPTLON',
        description: 'Internal Point Longitude',
        type: ee_const.var_type.double,
      },
      {
        name: 'MTFCC',
        description: 'MAF/TIGER Feature Classification Code',
        type: ee_const.var_type.string,
      },
      {
        name: 'NAMELSAD',
        description: 'Full Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATEFP',
        description: 'State FIPS Code',
        type: ee_const.var_type.string,
      },
      {
        name: 'TRACTCE',
        description: 'Census Tract Code',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Area 2020',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 13,
        },
        polygon_visualization: {
          property_name: 'AWATER',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              1e7,
            ],
            palette: ['d8d9d9', 'aaaaaa', 'b6dfe9', '2ea3f2', '0c71c3'],
          },
        },
      },
      {
        display_name: 'Water Area 2020',
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
      thinning_ranking: ['STATEFP ASC'],
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
