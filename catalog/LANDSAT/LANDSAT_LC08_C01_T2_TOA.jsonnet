local id = 'LANDSAT/LC08/C01/T2_TOA';

local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'LANDSAT/landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LC08_C01.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LC8_T2_TOA_versions.libsonnet';
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
  title: 'USGS Landsat 8 Collection 1 Tier 2 TOA Reflectance [deprecated]',
  version: version,
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 8 Collection 1 Tier 2 calibrated top-of-atmosphere (TOA) reflectance.
  ||| + landsat.toa,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'global',
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS/Google', 'https://landsat.usgs.gov/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2013-03-18T15:58:14Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
