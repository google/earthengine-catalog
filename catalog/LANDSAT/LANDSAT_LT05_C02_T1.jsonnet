local id = 'LANDSAT/LT05/C02/T1';
local subdir = 'LANDSAT';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.pddl_1_0;
local template = import 'templates/LT05_C02.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LT5_T1_versions.libsonnet';
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
  title: 'USGS Landsat 5 TM Collection 2 Tier 1 Raw Scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 5 TM Collection 2 Tier 1 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'c2',
    'global',
    'l5',
    'landsat',
    'lt5',
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
  extent: ee.extent_global('1984-03-16T16:20:00Z', '2012-05-05T17:54:06Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
