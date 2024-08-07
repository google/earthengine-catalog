local id = 'LANDSAT/LM03/C01/T2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LM03_C01.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'LM3_T2_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  "gee:skip_indexing": true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 3 MSS Collection 1 Tier 2 Raw Scenes [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 3 MSS Collection 1 Tier 2 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier2,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'c1',
    'global',
    'l3',
    'landsat',
    'lm3',
    'mss',
    'radiance',
    't2',
    'tier2',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/nli/landsat/landsat-1-5-multispectral-scanner-collection-1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1978-03-07T02:02:05Z', '1983-03-31T20:55:16Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
