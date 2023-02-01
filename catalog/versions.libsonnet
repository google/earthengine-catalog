// TODO(b/267511405): figure out if we should use this more widely
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename(id) = std.strReplace(id, '/', '_');
local configs(subdir, version_table) = {
  version_objects:: std.objectFields(version_table),
  last_index:: std.length(version_table) - 1,
  catalog_subdir_url:: ee_const.catalog_base + subdir + '/',
  versions: {
    [$['version_objects'][x]]: {

      version: $['version_objects'][x],

      id: version_table[self.version],
      basename: basename(self.id),
      ee_catalog_url: ee_const.ee_catalog_url + self.basename,

      predecessor:: ee.orEmptyDict(x != 0, {
          version: $['version_objects'][x - 1],
          id: version_table[self.version],
          basename: basename(self.id),
          url: $['catalog_subdir_url'] + self.basename + '.json'
      }),

      successor:: ee.orEmptyDict(x != $['last_index'], {
          version: $['version_objects'][x + 1],
          id: version_table[self.version],
          basename: basename(self.id),
          url: $['catalog_subdir_url'] + self.basename + '.json'
      }),

      latest:: {
          version: $['version_objects'][$['last_index']],
          id: version_table[self.version],
          basename: basename(self.id),
          url: $['catalog_subdir_url'] + self.basename + '.json',
      },

      version_links: [
         ee.link.latest(self.latest.id, self.latest.url)
      ] + ee.orEmptyArray(
          x != 0,
          [ee.link.predecessor(self.predecessor.id, self.predecessor.url)]
      ) + ee.orEmptyArray(
          x != $['last_index'],
          [ee.link.successor(self.successor.id, self.successor.url)]
      )
    }
    for x in std.range(0, $['last_index'])
  }
};

function(subdir, version_table, version)
  configs(subdir, version_table)['versions'][version]
