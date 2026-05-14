local id = 'TOMS/MERGED_V4';
local subdir = 'TOMS';

local ee_const = import 'earthengine_const.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'TOMS_MERGED_versions.libsonnet';
local template = import 'templates/TOMS_MERGED.libsonnet';

local version_config = versions(subdir, version_table, id);

template.TOMS_MERGED(
  id=id,
  version_config=version_config,
  extra_description='See [this document](https://acd-ext.gsfc.nasa.gov/anonftp/toms/omi/Changes_OMI_TO3_col4_col3.pdf) for a summary of changes between v3 and v4.',
  status='beta',
)
