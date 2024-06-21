local id = 'HU_BERLIN/EPFD/V2/points';
local subdir = 'HU_BERLIN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local epfd_v2 = import 'HU_BERLIN_EPFD_V2.libsonnet';
local version = '2.0';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_ver,
  ],
  type: ee_const.stac_type.collection,
  id: id,
  version: version,
  title: 'European Primary Forest Dataset - Points',
  'gee:type': ee_const.gee_type.table,
  description: epfd_v2.description + |||
      This dataset is a point-based, where each point represents the
      approximate center of a primary forest.
    |||,
  license: epfd_v2.license,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: epfd_v2.keywords,
  providers: epfd_v2.providers('', self_ee_catalog_url),
  extent: epfd_v2.extent,
  summaries: {
    'gee:schema': [
      { name: band.name, description: band.description, type: band.type }
      for band in epfd_v2.regular_bands
    ] + [
      {
        name: 'DATA_AVAIL',
        description: 'Data availability',
        type: ee_const.var_type.string,
      },
      {
        name: 'FOREST_EXT',
        description: |||
          The total extent of the primary forest patch in hectares. This field
          is only relevant when a polygon feature IS NOT available for the
          forest patch.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'FOREST_E_1',
        description: |||
          The order of magnitude of the extent of a primary forest remnant patch.
          This field is only relevant when a polygon feature IS NOT available for
          the forest patch and no precise measurement of the total extent of the
          forest remnant is available. Possible values:

          * 1: 1-10 ha
          * 2: 11-100 ha
          * 3: 101-1000 ha
          * 4: >1001 ha
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'PUBLICATIO',
        description: 'Publication',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'European Primary Forest Points',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: 13.64, lat: 50.11, zoom: 4},
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['Shape_Area DESC'],
    },
  },
  'gee:terms_of_use': epfd_v2.terms_of_use,
}
