local id = 'LANDSAT/LC09/C02/T2_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/LC08_C02.libsonnet';

local license = spdx.pddl_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'USGS Landsat 9 Collection 2 Tier 2 TOA Reflectance',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 9 Collection 2 Tier 2
      calibrated top-of-atmosphere (TOA) reflectance.
      Calibration coefficients are extracted from the image metadata.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.
  ||| + landsat.tier2,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c2',
    'global',
    'l9',
    'landsat',
    'lc9',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS/Google', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-8-data-users-handbook'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2021-11-02T01:06:10Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
