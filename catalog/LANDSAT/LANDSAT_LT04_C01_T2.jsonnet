local id = 'LANDSAT/LT04/C01/T2';
local subdir = 'LANDSAT';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.pddl_1_0;
local template = import 'templates/LT05_C01.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'LT4_T2_versions.libsonnet';
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
  title: 'USGS Landsat 4 TM Collection 1 Tier 2 Raw Scenes [deprecated]',
  version: version,
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 4 TM Collection 1 Tier 2 DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier2,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'c1',
    'global',
    'l4',
    'landsat',
    'lt4',
    'radiance',
    't2',
    'tier2',
    'tm',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/centers/eros/science/usgs-eros-archive-landsat-archives-landsat-4-5-thematic-mapper-tm-level-1-data'),
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
