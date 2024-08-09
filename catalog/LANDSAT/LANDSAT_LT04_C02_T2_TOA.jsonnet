local id = 'LANDSAT/LT04/C02/T2_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/LT05_C02.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LT4_T2_TOA_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.pddl_1_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 4 TM Collection 2 Tier 2 TOA Reflectance',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 4 TM Collection 2 Tier 2
      calibrated top-of-atmosphere (TOA) reflectance.
      Calibration coefficients are extracted from the image metadata.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
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
  extent: ee.extent_global('1982-08-22T14:18:20Z', '1993-11-18T14:54:14Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
