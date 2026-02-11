local id = 'WCMC/WDPA/current/polygons';
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
  title: 'WDPA: World Database on Protected Areas (polygons) [deprecated]',
  version: 'June 2020',
  'gee:type': ee_const.gee_type.table,
  'gee:status': 'deprecated',
  description: wcmc.wdpa_description,
  license: wcmc.license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.successor(
      'WCMC/WDPCA/current/polygons',
      ee_const.catalog_base + 'WCMC/WCMC_WDPCA_current_polygons.json'
    ),
  ],
  'gee:categories': ['ecosystems'],
  keywords: wcmc.keywords,
  providers: wcmc.providers(self_ee_catalog_url),
  // TODO(b/229788379): how to represent an ongoing end date?
  extent: ee.extent_global('2017-07-01T00:00:00Z', '2030-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      s.CONS_OBJ, s.DESIG, s.DESIG_ENG, s.DESIG_TYPE, s.GIS_AREA, s.GIS_M_AREA,
      s.GOV_TYPE, s.INT_CRIT, s.ISO3, s.IUCN_CAT, s.MANG_AUTH, s.MANG_PLAN,
      s.MARINE, s.METADATAID, s.NAME, s.NO_TAKE, s.NO_TK_AREA, s.ORIG_NAME,
      s.OWN_TYPE, s.PARENT_ISO3, s.PA_DEF, s.REP_AREA, s.REP_M_AREA, s.STATUS,
      s.STATUS_YR, s.SUB_LOC, s.SUPP_INFO, s.VERIF, s.WDPAID, s.WDPA_PID,
    ],
    'gee:visualizations': [
      {
        display_name: 'Protected Area Extent',
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
        display_name: 'Protected Area Extent',
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
