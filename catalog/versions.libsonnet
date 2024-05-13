local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename(id) = std.strReplace(id, '/', '_');
local configs(subdir, version_array) = {
  keys:: [std.objectValues(o)[0] for o in version_array],
  version_table:: {
    [std.objectValues(o)[0]]: std.objectFields(o)[0] for o in version_array},
  last_index:: std.length(self.keys) - 1,
  catalog_subdir_url:: ee_const.catalog_base + subdir + '/',

  versions: {
    [$['keys'][current_index]]: {
      id: $['keys'][current_index],

      version: $['version_table'][self.id],
      basename: basename(self.id),
      ee_catalog_url: ee_const.ee_catalog_url + self.basename,

      predecessor:: ee.orEmptyDict(current_index != 0, {
        id_index: current_index - 1,
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['catalog_subdir_url'] + self.basename + '.json',
      }),

      successor:: ee.orEmptyDict(current_index != $['last_index'], {
        id_index: current_index + 1,
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['catalog_subdir_url'] + self.basename + '.json',
      }),

      latest:: {
        id_index: $['last_index'],
        id: $['keys'][self.id_index],
        version: $['version_table'][self.id],
        basename: basename(self.id),
        url: $['catalog_subdir_url'] + self.basename + '.json',
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
