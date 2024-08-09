local id = 'LANDSAT/LC08/C02/T1_RT_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LC08_C02.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LC8_T1_RT_TOA_versions.libsonnet';
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
  title: 'USGS Landsat 8 Collection 2 Tier 1 and Real-Time data TOA Reflectance',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 8 Collection 2 Tier 1 and Real-Time data
      calibrated top-of-atmosphere (TOA) reflectance.
      Calibration coefficients are extracted from the image metadata.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.
  ||| + landsat.tier1,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c2',
    'global',
    'l8',
    'landsat',
    'lc8',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS/Google', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-8-data-users-handbook'),
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
