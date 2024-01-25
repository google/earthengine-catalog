local id = 'WM/geoLab/geoBoundaries/500/ADM2';
local subdir = 'WM';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local geoBoundaries = import 'WM_geoLab_geoBoundaries.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  id: id,
  title: 'WM: Political administrative boundaries at Municipality level (ADM2).',
  'gee:type': ee_const.gee_type.table,
  description: geoBoundaries.description + |||
      ADM2 is part of CGAZ and it has municipality-level boundaries.

      (see [Dataset description of WM global administation boundaries](
        https://www.geoboundaries.org/index.html).
    |||,
  license: geoBoundaries.license,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: geoBoundaries.keywords,
  providers: geoBoundaries.providers('', self_ee_catalog_url),
  extent: geoBoundaries.extent,
  summaries: {
    'gee:schema': [
      { name: band.name, description: band.description, type: band.type }
      for band in (geoBoundaries.regular_bands + geoBoundaries.shapeid_band)
    ],
    'gee:visualizations': [
      {
        display_name: 'Country Boundaries',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: -100, lat: 38.5, zoom: 4},
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['Shape_Area DESC'],
    },
  },
  'gee:terms_of_use': geoBoundaries.terms_of_use,
  'gee:unusual_terms_of_use': true,
}
