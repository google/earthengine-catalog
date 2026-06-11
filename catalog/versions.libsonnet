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

# Returns an object containing all of the version information for `id`
# taken from `version_table`, including related versions and the links
# between them.
#
# In the rare case that `id` links to something in `version_table` without
# explicitly being a member (e.g., multiple datasets are merged into a
# common successor), the current and successor versions can be passed as
# optional arguments to dynamically modify the `version_table` for a one-way
# link from `id`.
function(subdir, version_table, id,
         successor_version_key=null,
         successor_subdir=null,
         current_version=null)
  if successor_version_key == null then
    # Common case: `id` is in `version_table` and the version relationships
    # can be derived directly.
    configs(subdir, version_table)['versions'][id]
  else
    # Rare case: `id` is inserting itself into `version_table` before a
    # specific version.
    local resolved_successor_subdir =
      if successor_subdir != null then successor_subdir else subdir;

    local find_successor_index(table, key, idx=0) =
      if idx >= std.length(table) then
        error "Successor version key '" + key + "' not found in version table"
      else if std.objectFields(table[idx])[0] == key then
        idx
      else
        find_successor_index(table, key, idx + 1);

    local successor_index = find_successor_index(version_table, successor_version_key);
    local slice(arr, start, len) = [
      arr[i] for i in std.range(start, start + len - 1)
    ];
    local sliced_table = slice(version_table, successor_index, std.length(version_table) - successor_index);

    local current_version_key = if current_version != null then current_version else ee_const.version_unknown;
    local pred = {
      [current_version_key]: {
        id: id,
        subdir: subdir
      }
    };

    local new_table = [pred] + sliced_table;
    configs(resolved_successor_subdir, new_table)['versions'][id]
