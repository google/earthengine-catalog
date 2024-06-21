local id = 'HU_BERLIN/EPFD/V2/polygons';
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
  title: 'European Primary Forest Dataset - Polygons',
  'gee:type': ee_const.gee_type.table,
  description: epfd_v2.description + |||
      This dataset is a polygon-based, where each polygon represents a
      primary forest with boundaries.
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
        name: 'Area_ha',
        description: 'Area of the forest polygon in ha',
        type: ee_const.var_type.double,
      },
      {
        name: 'SHAPE_Area',
        description: 'Area of the polygon',
        type: ee_const.var_type.double,
      },
      {
        name: 'SHAPE_Leng',
        description: 'Length of the polygon',
        type: ee_const.var_type.double,
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'European Primary Forest Polygons',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: 39.64, lat: 61.11, zoom: 4},
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
