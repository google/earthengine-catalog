local id = 'USDOS/LSIB/2017';
local subdir = 'USDOS';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LSIB 2017: Large Scale International Boundary Polygons, Detailed',
  version: '2017',
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
    ee.link.example(id, subdir, basename + '_FeatureView'),
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
    ee.producer_provider('United States Department of State, Office of the Geographer', 'https://geonode.state.gov/layers/catalog:geonode:LSIB'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2017-12-29T00:00:00Z', '2017-12-29T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'OBJECTID',
        description: 'Object ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'COUNTRY_NA',
        description: 'US-recognized country name',
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
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'gee:terms_of_use': 'There are no restrictions on use of this US public domain data.',
}
