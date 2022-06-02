local id = 'USDOS/LSIB/2013';
local successor_id = 'USDOS/LSIB/2017';
local subdir = 'USDOS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LSIB 2013: Large Scale International Boundary Polygons, Detailed [deprecated]',
  version: '2013',
  deprecated: true,
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Office of the Geographer provides
    the Large Scale International Boundary (LSIB) dataset. It is derived
    from two other datasets: a LSIB line vector file and the World
    Vector Shorelines (WVS) from the National Geospatial-Intelligence
    Agency (NGA). The interior boundaries reflect U.S. government policies
    on boundaries, boundary disputes, and sovereignty. The exterior
    boundaries are derived from the WVS; however, the WVS coastline
    data is outdated and generally shifted from between several hundred
    meters to over a kilometer. Each feature is the polygonal area
    enclosed by interior boundaries and exterior coastlines where applicable,
    and many countries consist of multiple features, one per disjoint
    region. Each of the 180,741 features is a part of the geometry
    of one of the 284 countries described in this dataset.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'borders',
    'boundaries',
    'countries',
    'dos',
    'political',
    'usdos',
  ],
  providers: [
    ee.producer_provider('United States Department of State, Office of the Geographer', 'https://geonode.state.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2013-03-08T00:00:00Z', '2013-03-08T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'cc',
        description: '[Two-letter FIPS country code](https://en.wikipedia.org/wiki/List_of_FIPS_country_codes)',
        type: ee_const.var_type.string,
      },
      {
        name: 'iso_alpha2',
        description: 'ISO 3166-1 alpha-2 country code',
        type: ee_const.var_type.string,
      },
      {
        name: 'iso_alpha3',
        description: 'ISO 3166-1 alpha-3 country code',
        type: ee_const.var_type.string,
      },
      {
        name: 'iso_num',
        description: 'Country record ID',
        type: ee_const.var_type.double,
      },
      {
        name: 'name',
        description: 'US-recognized country name',
        type: ee_const.var_type.string,
      },
      {
        name: 'region',
        description: 'Abbreviated continental region, e.g. EUROPE-SW ASIA',
        type: ee_const.var_type.string,
      },
      {
        name: 'tld',
        description: 'Internet top-level domain',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Countries',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        polygon_visualization: {
          property_name: 'iso_num',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              894.0,
            ],
            palette: [
              'f5ff64',
              'b5ffb4',
              'beeaff',
              'ffc0e8',
              '8e8dff',
              'adadad',
            ],
          },
        },
      },
      {
        display_name: 'Countries',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1000,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'gee:terms_of_use': 'There are no restrictions on use of this US public domain data.',
}
