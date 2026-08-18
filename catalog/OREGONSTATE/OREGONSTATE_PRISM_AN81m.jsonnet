local prism = import 'prism.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/PRISM_ANm_versions.libsonnet';
local subdir = 'OREGONSTATE';
local ee = import 'earthengine.libsonnet';

local id = 'OREGONSTATE/PRISM/AN81m';
local version_config = versions(subdir, version_table, id);

prism {
  params+:: { period: 'monthly' },
  id: id,
  title: 'PRISM Monthly Spatial Climate Dataset AN81m [deprecated]',
  'gee:status': 'deprecated',
  version: version_config.version,
  links+: version_config.version_links,
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0, '1895-01-01T00:00:00Z', null),
}

