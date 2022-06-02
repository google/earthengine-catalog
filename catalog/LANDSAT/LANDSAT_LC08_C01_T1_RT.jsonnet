local id = 'LANDSAT/LC08/C01/T1_RT';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LC08_C01.libsonnet';

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
  title: 'USGS Landsat 8 Collection 1 Tier 1 and Real-Time data Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 8 Collection 1 Tier 1 and Real-Time data DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1_rt,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c1',
    'global',
    'l8',
    'landsat',
    'lc8',
    'nrt',
    'oli_tirs',
    'radiance',
    'rt',
    't1',
    'tier1',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-8-data-users-handbook'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2013-03-18T15:59:02Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
