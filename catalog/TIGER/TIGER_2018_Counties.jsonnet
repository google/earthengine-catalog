local id = 'TIGER/2018/Counties';
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
  title: 'TIGER: US Census Counties 2018',
  version: '2018',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau TIGER dataset contains the 2018 boundaries
    for primary legal divisions of US states.  In most states, these entities
    are termed "counties". In Louisiana, these divisions are known as
    "parishes".

    Alaska has governmental entities called "boroughs" which fill a similar
    governmental role to counties, but in some areas those governmental
    responsibilities are handled directly by the state and sometimes by a city.
    For Alaska, county equivalent entities thus include

    1. organized boroughs,
    1. combined city and borough entities (e.g. Juneau),
    1. municipalities, and
    1. census areas.

    The census areas are delineated cooperatively for statistical purposes by
    the State of Alaska and the Census Bureau.

    In four states (Maryland, Missouri, Nevada, and Virginia), there are one
    or more incorporated places that are independent of any county
    organization and thus constitute primary divisions of their states. These
    incorporated places are known as independent cities and are treated as
    county-equivalent entities for purposes of data presentation.

    The District of Columbia and Guam have no primary divisions and each area is
    considered a county-equivalent entity for purposes of data presentation.
    The Census Bureau treats the following entities as equivalents of counties
    for purposes of data presentation: municipios in Puerto Rico, districts
    and islands in America Samoa, municipalities in the Commonwealth of the
    Northern Mariana Islands, and islands in the U.S. Virgin Islands.

    For full technical details on all TIGER 2018 products, see the [TIGER
    technical documentation.](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2018/TGRSHP2018_TechDoc.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'source',
      href: 'ftp://ftp2.census.gov/geo/tiger/TIGER2018/COUNTY/tl_2018_us_county.zip',
    },
  ],
  keywords: [
    'census',
    'counties',
    'county',
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
        name: 'CBSAFP',
        description: 'Metropolitan statistical area/micropolitan statistical area code',
        type: ee_const.var_type.string,
      },
      {
        name: 'CLASSFP',
        description: 'FIPS class code',
        type: ee_const.var_type.string,
      },
      {
        name: 'COUNTYFP',
        description: 'County FIPS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'COUNTYNS',
        description: 'County GNIS code',
        type: ee_const.var_type.string,
      },
      {
        name: 'CSAFP',
        description: 'Combined statistical area code',
        type: ee_const.var_type.string,
      },
      {
        name: 'FUNCSTAT',
        description: 'Functional Status',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOID',
        description: 'County identifier; a concatenation of state FIPS code and county FIPS code',
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
        description: 'Legal/statistical area description for the county',
        type: ee_const.var_type.string,
      },
      {
        name: 'METDIVFP',
        description: 'Metropolitan division code',
        type: ee_const.var_type.string,
      },
      {
        name: 'MTFCC',
        description: 'MAF/TIGER feature class code (=G4020)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NAME',
        description: 'County name',
        type: ee_const.var_type.string,
      },
      {
        name: 'NAMELSAD',
        description: 'Name and the translated legal/statistical area description for the county',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATEFP',
        description: 'State FIPS code',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'County Boundaries',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
        polygon_visualization: {
          property_name: 'ALAND',
          property_vis: {
            min: [
              9000000000.0,
            ],
            max: [
              50000000000.0,
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
        display_name: 'County Boundaries',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 4000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: 'ALAND DESC',
      prerender_tiles: true,
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
