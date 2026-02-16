local id = 'WCMC/WDPCA/current/polygons';
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
  title: 'WDPCA: World Database on Protected and Conserved Areas (polygons)',
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
      s.CONS_OBJ, s.DESIG, s.DESIG_ENG, s.DESIG_TYPE, s.GIS_AREA, s.GIS_M_AREA,
      s.GOVSUBTYPE, s.GOV_TYPE, s.INLND_WTRS, s.INT_CRIT, s.ISO3, s.IUCN_CAT,
      s.MANG_AUTH, s.MANG_PLAN, s.METADATAID, s.NAME, s.NAME_ENG, s.NO_TAKE,
      s.NO_TK_AREA, s.OECM_ASMT, s.OWNSUBTYPE, s.OWN_TYPE, s.PRNT_ISO3,
      s.REALM, s.REP_AREA, s.REP_M_AREA, s.SITE_ID, s.SITE_PID, s.SITE_TYPE,
      s.STATUS, s.STATUS_YR, s.SUPP_INFO, s.VERIF,
    ],
    'gee:visualizations': [
      {
        display_name: 'Site Extent',
        lookat: {
          lat: -9.8,
          lon: 124.45,
          zoom: 2,
        },
        polygon_visualization: {
          property_name: 'REP_AREA',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              1550000.0,
            ],
            palette: [
              '2ed033',
              '5aff05',
              '67b9ff',
              '5844ff',
              '0a7618',
              '2c05ff',
            ],
          },
        },
      },
      {
        display_name: 'Site Extent',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
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
