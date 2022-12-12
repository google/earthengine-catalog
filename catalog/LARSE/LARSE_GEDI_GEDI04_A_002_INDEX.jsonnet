local id = 'LARSE/GEDI/GEDI04_A_002_INDEX';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local gedi = importstr 'gedi.md';
local gedi_l4a = import 'gedi_l4a.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L4A table index',
  version: '2.1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This is a feature collection created from the geometries of L4A tables in
    [LARSE/GEDI/GEDI04_A_002](LARSE_GEDI_GEDI04_A_002). Each feature is
    a polygon footprint of a source table with its asset id and start/end
    timestamps.

    Please see [User Guide](https://daac.ornl.gov/GEDI/guides/GEDI_L4A_AGB_Density_V2_1.html)
    for more information.
  ||| + gedi,
  license: gedi_l4a.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi_l4a.keywords,
  providers: gedi_l4a.providers('Indexing: Google and ', self_ee_catalog_url),
  extent: {
    spatial: gedi_l4a.extent.spatial,
    // TODO(b/229788379): figure out what to do about the end date of table
    // collections.
    temporal: { interval: [['2019-04-18T00:00:00Z', '2022-06-09T00:00:00Z']] }
  },
  summaries: {
    'gee:schema': [
      {
        name: 'table_id',
        description: 'GEDI L4A table collection Ids',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_start',
        description: 'GEDI L4A table start time in the ISO 8601 format',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_end',
        description: 'GEDI L4A table end time in the ISO 8601 format',
        type: ee_const.var_type.string,
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'preview',
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
        lookat: {
          lat: 29,
          lon: 37,
          zoom: 3,
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
  'sci:citation': gedi_l4a.citation,
  'gee:terms_of_use': gedi_l4a.terms_of_use,
}
