local id = 'LANDSAT/LM05/C02/T2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LM05_C02.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'LM5_T2_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 5 MSS Collection 2 Tier 2 Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 5 MSS Collection 2 Tier 2 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier2,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c2',
    'global',
    'l5',
    'landsat',
    'lm5',
    'mss',
    'radiance',
    't2',
    'tier2',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/landsat-missions/landsat-collection-2-level-1-data'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1984-04-07T10:04:11Z', '2013-01-01T16:51:58Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
