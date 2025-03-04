local id = 'WRI/Aqueduct_Water_Risk/V4/future_annual';
local subdir = 'WRI';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local aqueduct_water_risk = import 'WRI_Aqueduct_Water_Risk.libsonnet';
local future_annual = import 'WRI_Aqueduct_Water_Risk_future_annual.libsonnet';
local baseline_monthly = import 'WRI_Aqueduct_Water_Risk_baseline_monthly.libsonnet';

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
  title: 'WRI Aqueduct Future Annual Version 4.0',
  version: '4.0',
  'gee:type': ee_const.gee_type.table,
  description: aqueduct_water_risk.description +
    future_annual.description +
    aqueduct_water_risk.description_footer,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://www.wri.org/data/aqueduct-global-maps-40-data',
    },
  ],
  'gee:categories': ['surface-ground-water'],
  keywords: aqueduct_water_risk.keywords,
  providers: [
    ee.producer_provider('World Resources Institute', 'https://www.wri.org/data/aqueduct-global-maps-40-data'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2010-01-01T00:00:00Z', '2080-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': future_annual.identifiers +
    [
      {
        name: scenario.name + year.name + '_' + indicator.name + '_x_' +
        type.short_name,
        description: std.join(
          ' ',
          [indicator.description, type.description, 'projected by year',
          year.description, 'under', scenario.description, 'scenario']
        ),
        type: type.type,
      }
      for scenario in future_annual.scenarios_dict
      for year in future_annual.years_dict
      for indicator in future_annual.indicators_dict
      for type in baseline_monthly.types_desc_dict
      if ((indicator.name == 'ba' || indicator.name == 'ww') &&
          (type.name == 'score' || type.name == 'cat')) == false
    ]
    ,
    'gee:visualizations': [
      {
        display_name: 'Projected Low Water Stress by 2080',
        lookat: {
          lon: 10,
          lat: 20,
          zoom: 4,
        },
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
      },
      {
        display_name: 'Projected Low Water Stress by 2080',
        visualize_as: 'FeatureView',
        lookat: {
          lon: 10,
          lat: 20,
          zoom: 4,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 6000,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['pfaf_id DESC'],
      z_order_ranking: ['pfaf_id ASC'],
      prerender_tiles: true,
    },
  },
  'gee:terms_of_use': aqueduct_water_risk.terms_of_use,
}
