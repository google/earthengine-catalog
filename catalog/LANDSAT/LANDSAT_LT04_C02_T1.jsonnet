local id = 'LANDSAT/LT04/C02/T1';
local subdir = 'LANDSAT';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.pddl_1_0;
local template = import 'templates/LT05_C02.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LT4_T1_versions.libsonnet';
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
  title: 'USGS Landsat 4 TM Collection 2 Tier 1 Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 4 TM Collection 2 Tier 1 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c2',
    'global',
    'l4',
    'landsat',
    'lt4',
    'radiance',
    't1',
    'tier1',
    'tm',
    'usgs'
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/centers/eros/science/usgs-eros-archive-landsat-archives-landsat-4-5-thematic-mapper-tm-level-1-data'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1982-08-22T14:19:55Z', '1993-12-14T00:00:00Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
