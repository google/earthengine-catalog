local id = 'WCMC/WDPCA/current/points';
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
  title: 'WDPCA: World Database on Protected and Conserved Areas (points)',
  version: 'January 2026',
  'gee:type': ee_const.gee_type.table,
  description: wcmc.wdpca_description,
  license: wcmc.license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  'gee:categories': ['ecosystems'],
  keywords: wcmc.keywords,
  providers: wcmc.providers(self_ee_catalog_url),
  extent: ee.extent_global('2026-01-01T00:00:00Z', '2030-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      s.CONS_OBJ, s.DESIG, s.DESIG_ENG, s.DESIG_TYPE, s.GOVSUBTYPE, s.GOV_TYPE,
      s.INLND_WTRS, s.INT_CRIT, s.ISO3, s.IUCN_CAT, s.MANG_AUTH, s.MANG_PLAN,
      s.METADATAID, s.NAME, s.NAME_ENG, s.NO_TAKE, s.NO_TK_AREA, s.OECM_ASMT,
      s.OWNSUBTYPE, s.OWN_TYPE, s.PRNT_ISO3, s.REALM, s.REP_AREA, s.REP_M_AREA,
      s.SITE_ID, s.SITE_PID, s.SITE_TYPE, s.STATUS, s.STATUS_YR, s.SUPP_INFO,
      s.VERIF,
    ],
    'gee:visualizations': [
      {
        display_name: 'Site Points',
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
        display_name: 'Site Points',
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
