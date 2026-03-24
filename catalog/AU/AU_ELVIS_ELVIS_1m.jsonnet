local id = 'AU/ELVIS/ELVIS_1m';
local subdir = 'AU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local elvis = import 'AU/ELVIS.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Australia ELVIS Digital Elevation Model 1m',
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: |||
    The 1m DEM tiles from ELVIS represent high-resolution bare earth elevation
    data derived from airborne LiDAR surveys across Australia. The 1m DEM is
    generated from LiDAR point cloud data classified as ground, interpolated
    onto a regular 1-metre grid. This resolution provides detailed terrain
    information suitable for site-level engineering, urban flood modelling, and
    detailed environmental analysis.
  ||| + elvis.common_description,
  license: elvis.license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(elvis.license.reference),
  ],
  'gee:categories': ['elevation-topography'],
  keywords: elvis.common_keywords,
  providers: [
    ee.producer_provider(elvis.provider.name, elvis.provider.url),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(114.09, -43.45, 153.64, -9.88,
                    '2016-03-01T00:00:00Z', null),
  summaries: {
    gsd: [1.0],
    'eo:bands': [
      elvis.elevation_band,
    ],
    'gee:visualizations': elvis.visualizations,
  },
  'gee:terms_of_use': elvis.terms_of_use,
}
