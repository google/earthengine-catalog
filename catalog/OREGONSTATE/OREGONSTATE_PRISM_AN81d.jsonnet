local prism = import 'prism.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/PRISM_ANd_versions.libsonnet';
local subdir = 'OREGONSTATE';

local id = 'OREGONSTATE/PRISM/AN81d';
local version_config = versions(subdir, version_table, id);

prism {
  id: id,
  title: 'PRISM Daily Spatial Climate Dataset AN81d [deprecated]',
  'gee:status': 'deprecated',
  version: version_config.version,
  links+: version_config.version_links,
}

