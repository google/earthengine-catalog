local id = 'LANDSAT/LM01/C01/T1';
local latest_id = 'LANDSAT/LM01/C02/T1';
local successor_id = 'LANDSAT/LM01/C02/T1';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LM03_C01.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/',  '_');
local successor_filename = successor_basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local latest_url = catalog_subdir_url + latest_filename;
local successor_url = catalog_subdir_url + successor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'USGS Landsat 1 MSS Collection 1 Tier 1 Raw Scenes [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 1 MSS Collection 1 Tier 1 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(
      successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'c1',
    'global',
    'l1',
    'landsat',
    'lm1',
    'mss',
    'radiance',
    't1',
    'tier1',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/nli/landsat/landsat-1-5-multispectral-scanner-collection-1'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1972-07-26T14:46:24Z', '1978-01-06T16:11:54Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
