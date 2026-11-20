local id = 'LARSE/GEDI/GEDI02_B_003_INDEX';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l2a = import 'gedi_l2a.libsonnet';
local gedi_l2b = import 'gedi_l2b.libsonnet';
local gedi = importstr 'gedi_v3.md';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L2B Table Index (Version 3)',
  version: '3',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This is a feature collection created from the geometries of L2B tables in
    [LARSE/GEDI/GEDI02_B_003](LARSE_GEDI_GEDI02_B_003). Each feature is
    a polygon footprint of a source table with its asset ID and start/end
    timestamps.

    Please see the [User
    Guide](https://lpdaac.usgs.gov/documents/2442/GEDI02_User_Guide_V3.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  'gee:categories': ['forest-biomass'],
  keywords: gedi_l2a.keywords,
  providers: gedi_l2a.providers(
    'Indexing: Google and ',
    self_ee_catalog_url,
    'https://doi.org/10.5067/GEDI/GEDI02_B.003'
  ),
  extent: {
    spatial: gedi_l2a.extent.spatial,
    temporal: { interval: [['2019-04-04T00:00:00Z', null]] },
  },
  summaries: {
    'gee:schema': [
      {
        name: 'table_id',
        description: 'GEDI L2B table asset ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_start',
        description: 'GEDI L2B table start time in ISO 8601 format',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_end',
        description: 'GEDI L2B table end time in ISO 8601 format',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'preview',
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
        lookat: {
          lon: -60.0,
          lat: -5.0,
          zoom: 4,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['time_start DESC'],
      z_order_ranking: ['time_start DESC'],
    },
  },
  'sci:doi': '10.5067/GEDI/GEDI02_B.003',
  'sci:citation': gedi_l2b.citation_v3,
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
