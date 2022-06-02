local id = 'TIGER/2018/States';
local subdir = 'TIGER';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census States 2018',
  version: '2018',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau TIGER dataset contains the 2018 boundaries
    for the primary governmental divisions of the United States. In addition
    to the fifty states, the Census Bureau treats the District of Columbia,
    Puerto Rico, and each of the island areas (American Samoa, the Commonwealth
    of the Northern Mariana Islands, Guam, and the U.S. Virgin Islands) as the
    statistical equivalents of States for the purpose of data presentation.
    Each feature represents a state or state equivalent.

    For full technical details on all TIGER 2018 products, see the [TIGER
    technical documentation.](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2018/TGRSHP2018_TechDoc.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'source',
      href: 'ftp://ftp2.census.gov/geo/tiger/TIGER2018/STATE/tl_2018_us_state.zip',
    },
  ],
  keywords: [
    'census',
    'state',
    'states',
    'tiger',
    'us',
  ],
  providers: [
    ee.producer_provider('United States Census Bureau', 'https://www.census.gov/programs-surveys/geography/guidance/tiger-data-products-guide.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, -64.435, 71.567,
                    '2018-01-01T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ALAND',
        description: 'Land area',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
      {
        name: 'AWATER',
        description: 'Water area',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
      {
        name: 'DIVISION',
        description: 'Division code',
        type: ee_const.var_type.string,
      },
      {
        name: 'FUNCSTAT',
        description: 'Functional Status',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOID',
        description: 'State identifier; state FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLAT',
        description: 'Internal point latitude',
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLON',
        description: 'Internal point longitude',
        type: ee_const.var_type.string,
      },
      {
        name: 'LSAD',
        description: 'Legal/statistical area description for state',
        type: ee_const.var_type.string,
      },
      {
        name: 'MTFCC',
        description: 'MAF/TIGER feature class code (=G4000)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NAME',
        description: 'State name',
        type: ee_const.var_type.string,
      },
      {
        name: 'REGION',
        description: 'Region code',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATEFP',
        description: 'State FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATENS',
        description: 'State GNIS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'STUSPS',
        description: 'US Postal Service state abbreviation',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'State Boundaries',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
        polygon_visualization: {
          property_name: 'ALAND',
          property_vis: {
            min: [
              500000000.0,
            ],
            max: [
              500000000000.0,
            ],
            palette: [
              'purple',
              'blue',
              'green',
              'yellow',
              'orange',
              'red',
            ],
          },
        },
      },
      {
        display_name: 'State Boundaries',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    For the creation of any reports, publications, new data sets, derived
    products, or services resulting from the data set, users should
    [cite the US Census Bureau.](https://www.census.gov/about/policies/citation.html)
  |||,
  'gee:terms_of_use': |||
    The U.S. Census Bureau offers some of its public data
    in machine-readable format via an Application Programming Interface
    (API). All of the content, documentation, code and related materials
    made available through the API are subject to [these terms and
    conditions.](https://www.census.gov/data/developers/about/terms-of-service.html)
  |||,
}
