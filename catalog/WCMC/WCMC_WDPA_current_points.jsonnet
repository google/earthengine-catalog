local id = 'WCMC/WDPA/current/points';
local subdir = 'WCMC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local wcmc = import 'wcmc_common.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local s = wcmc.schema_fields;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WDPA: World Database on Protected Areas (points) [deprecated]',
  version: 'June 2020',
  'gee:type': ee_const.gee_type.table,
  'gee:status': 'deprecated',
  description: wcmc.wdpa_description,
  license: wcmc.license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.successor(
      'WCMC/WDPCA/current/points',
      ee_const.catalog_base + 'WCMC/WCMC_WDPCA_current_points.json'
    ),
  ],
  'gee:categories': ['ecosystems'],
  keywords: wcmc.keywords,
  providers: wcmc.providers(self_ee_catalog_url),
  // TODO(b/229788379): how to represent an ongoing end date?
  extent: ee.extent_global('2017-07-01T00:00:00Z', '2030-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      s.CONS_OBJ, s.DESIG, s.DESIG_ENG, s.DESIG_TYPE, s.GOV_TYPE, s.INT_CRIT,
      s.ISO3, s.IUCN_CAT, s.MANG_AUTH, s.MANG_PLAN, s.MARINE, s.METADATAID,
      s.NAME, s.NO_TAKE, s.NO_TK_AREA, s.ORIG_NAME, s.OWN_TYPE, s.PARENT_ISO3,
      s.PA_DEF, s.REP_AREA, s.REP_M_AREA, s.STATUS, s.STATUS_YR, s.SUB_LOC,
      s.SUPP_INFO, s.VERIF, s.WDPAID, s.WDPA_PID,
    ],
    'gee:visualizations': [
      {
        display_name: 'Protected Area Points',
        lookat: {
          lat: 0.88,
          lon: 110.57,
          zoom: 4,
        },
        table_visualization: {
          color: '4285f4',
          point_size: 3,
        },
      },
      {
        display_name: 'Protected Area Points',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 0.88,
          lon: 110.57,
          zoom: 4,
        },
        feature_view_visualization: {
          color: '4285F4',
          point_size: 14,
          point_shape: 'hexagon',
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['REP_AREA DESC'],
      z_order_ranking: ['REP_AREA DESC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': wcmc.citation,
  'gee:terms_of_use': wcmc.terms_of_use,
  'gee:unusual_terms_of_use': wcmc.unusual_terms_of_use,
}
