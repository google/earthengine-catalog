local harmonized = import 'templates/harmonized.libsonnet';
local subdir = 'COPERNICUS';
local template = import 'templates/S2_SR.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'COPERNICUS_S2_SR_versions.libsonnet';

local id = 'COPERNICUS/S2_SR_HARMONIZED';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

template.s2_dataset(id, version, version_config) {
  title: 'Harmonized ' + super.title,
  description: harmonized.description + super.description,
}
