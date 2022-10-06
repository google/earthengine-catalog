local id = 'LANDSAT/LE07/C01/T1_RT';
local latest_id = 'LANDSAT/LE07/C02/T1_RT';
local successor_id = 'LANDSAT/LE07/C02/T1_RT';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LE07_C01.libsonnet';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS Landsat 7 Collection 1 Tier 1 and Real-Time data Raw Scenes [deprecated]',
  version: 'C1',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 7 Collection 1 Tier 1 and Real-Time data DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1_rt + landsat.l7_drift,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(
      successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'c1',
    'etm',
    'global',
    'l7',
    'landsat',
    'le7',
    'nrt',
    'radiance',
    'rt',
    't1',
    'tier1',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-7-data-users-handbook'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1999-05-28T01:02:17Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
