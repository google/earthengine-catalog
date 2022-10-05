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

local last_index = std.length(version_table) - 1;

local subdir = 'UMD';
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

local basename(id) = std.strReplace(id, '/', '_');

local versions = std.objectFields(version_table);
local arr = std.range(0, std.length(versions) - 1);
{
  [versions[x]]: {
    version: versions[x],

    id: version_table[self.version],
    basename: basename(self.id),
    base_filename: self.basename + '.json',
    self_url: catalog_subdir_url + self.base_filename,
    self_ee_catalog_url: ee_const.ee_catalog_url + self.basename,

    latest_version: versions[std.length(versions) - 1],
    latest_id: version_table[self.latest_version],
    latest_basename: basename(self.latest_id),
    latest_url: catalog_subdir_url + self.latest_basename + '.json',

    last_index: last_index,

    version_links: [
       ee.link.latest(self.latest_id, self.latest_url)
    ] + ee.orEmptyArray(
        x != 0,
        [ee.link.predecessor(self.predecessor_id, self.predecessor_url)]
    ) + ee.orEmptyArray(
        x != last_index,
        [ee.link.successor(self.successor_id, self.successor_url)]
    )
    } + ee.orEmptyDict(x != 0, {
        predecessor_version: versions[x - 1],
        predecessor_id: version_table[self.predecessor_version],
        predecessor_basename: basename(self.predecessor_id),
        predecessor_url: catalog_subdir_url + self.predecessor_basename +
        '.json'
    }) + ee.orEmptyDict(x != last_index, {
        successor_version: versions[x + 1],
        successor_id: version_table[self.successor_version],
        successor_basename: basename(self.successor_id),
        successor_url: catalog_subdir_url + self.successor_basename + '.json'
    })
  for x in arr
}
