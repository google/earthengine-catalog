local id = 'TOMS/MERGED';
local subdir = 'TOMS';

local ee_const = import 'earthengine_const.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'TOMS_MERGED_versions.libsonnet';
local template = import 'templates/TOMS_MERGED.libsonnet';

local version_config = versions(subdir, version_table, id);

template.TOMS_MERGED(
  id=id,
  version_config=version_config,
  title_suffix=' [deprecated]',
  status='deprecated'
)
