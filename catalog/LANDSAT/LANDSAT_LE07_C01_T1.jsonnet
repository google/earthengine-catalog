local id = 'LANDSAT/LE07/C01/T1';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LE07_C01.libsonnet';

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
  title: 'USGS Landsat 7 Collection 1 Tier 1 Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 7 Collection 1 Tier 1 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1 + landsat.l7_drift,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c1',
    'etm',
    'global',
    'l7',
    'landsat',
    'le7',
    'radiance',
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
