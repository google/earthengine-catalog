local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local version_table = {
  'v1.0': 'UMD/hansen/global_forest_change_2013',
  'v1.1': 'UMD/hansen/global_forest_change_2014',
  'v1.2': 'UMD/hansen/global_forest_change_2015',
  'v1.3': 'UMD/hansen/global_forest_change_2015_v1_3',
  'v1.4': 'UMD/hansen/global_forest_change_2016_v1_4',
  'v1.5': 'UMD/hansen/global_forest_change_2017_v1_5',
  'v1.6': 'UMD/hansen/global_forest_change_2018_v1_6',
  'v1.7': 'UMD/hansen/global_forest_change_2019_v1_7',
  'v1.8': 'UMD/hansen/global_forest_change_2020_v1_8',
  'v1.9': 'UMD/hansen/global_forest_change_2021_v1_9',
};
local subdir = 'UMD';


local basename(id) = std.strReplace(id, '/', '_');
{
  version_objects:: std.objectFields(version_table),
  last_index:: std.length(version_table) - 1,
  catalog_subdir_url:: ee_const.catalog_base + subdir + '/',
  versions: {
    [$['version_objects'][x]]: {

      version: $['version_objects'][x],

      id: version_table[self.version],
      basename: basename(self.id),
      base_filename: self.basename + '.json',
      self_url: $['catalog_subdir_url'] + self.base_filename,
      self_ee_catalog_url: ee_const.ee_catalog_url + self.basename,

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
}
