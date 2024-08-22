local template = import 'templates/S2_SR.libsonnet';
local subdir = 'COPERNICUS';

local versions = import 'versions.libsonnet';
local version_table = import 'COPERNICUS_S2_SR_versions.libsonnet';

local id = 'COPERNICUS/S2_SR';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

template.s2_dataset(id, version, version_config) {
  'gee:status': 'deprecated',
  title: super.title + ' [deprecated]',
  description: |||
  See also collection COPERNICUS/S2_SR_HARMONIZED that shifts data with
  PROCESSING_BASELINE '04.00' or above (after 2022-01-25) to be in the same range
  as in older scenes.

||| + super.description
}
