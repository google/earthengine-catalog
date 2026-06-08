# This file defines a function to resolve version configurations for datasets.
#
# The version_table (passed as version_array to configs) can have the following
# formats:
#
# 1. String values:
#    [
#      { '1.0': 'SUBDIR/DATASET_V1' },
#      { '2.0': 'SUBDIR/DATASET_V2' },
#    ]
#    All datasets are assumed to be in the same 'subdir' passed to the function.
#
# 2. Object values:
#    [
#      { '1.0': { id: 'SUBDIR1/DATASET_V1', subdir: 'SUBDIR1' } },
#      { '2.0': { id: 'SUBDIR2/DATASET_V2', subdir: 'SUBDIR2' } },
#    ]
#    - 'id': The dataset ID (required).
#    - 'subdir': The subdirectory where the dataset resides (optional,
#      defaults to the caller's subdir).
#
# Versions are expected to increase from top to bottom, making the last item in
# the list the latest version.

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename(id) = std.strReplace(id, '/', '_');

local get_id(val) = if std.type(val) == 'string' then val else val.id;

local get_url(val, default_subdir) =
  if std.type(val) == 'string' then
    ee_const.catalog_base + default_subdir + '/' + basename(val) + '.json'
  else if std.objectHas(val, 'subdir') then
    ee_const.catalog_base + val.subdir + '/' + basename(val.id) + '.json'
  else
    ee_const.catalog_base + default_subdir + '/' + basename(val.id) + '.json';

local configs(subdir, version_array) = {
  keys:: [get_id(std.objectValues(o)[0]) for o in version_array],
  version_table:: {
    [get_id(std.objectValues(o)[0])]: std.objectFields(o)[0]
    for o in version_array
  },
  url_table:: {
    [get_id(std.objectValues(o)[0])]: get_url(std.objectValues(o)[0], subdir)
    for o in version_array
  },
  last_index:: std.length(self.keys) - 1,

  versions: {
    [$['keys'][current_index]]: {
      id: $['keys'][current_index],

      version:
        local raw_version = $['version_table'][self.id];
        if std.endsWith(raw_version, ee_const.version_deprecated_suffix) then
          std.substr(raw_version, 0, std.length(raw_version) - std.length(ee_const.version_deprecated_suffix))
        else
          raw_version,
      basename: basename(self.id),
      ee_catalog_url: ee_const.ee_catalog_url + self.basename,

      predecessor:: ee.orEmptyDict(current_index != 0, {
        id_index: current_index - 1,
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['url_table'][self.id],
      }),

      successor:: ee.orEmptyDict(current_index != $['last_index'], {
        id_index: current_index + 1,
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['url_table'][self.id],
      }),

      latest:: {
        id_index: $['last_index'],
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['url_table'][self.id],
      },

      version_links: [
         ee.link.latest(self.latest.id, self.latest.url)
      ] + ee.orEmptyArray(
          current_index != 0,
          [ee.link.predecessor(self.predecessor.id, self.predecessor.url)]
      ) + ee.orEmptyArray(
          current_index != $['last_index'],
          [ee.link.successor(self.successor.id, self.successor.url)]
      ),
    }
    for current_index in std.range(0, self.last_index)
  }
};

function(subdir, version_table, id)
  configs(subdir, version_table)['versions'][id]
