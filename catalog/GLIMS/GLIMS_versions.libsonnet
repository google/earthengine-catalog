local ee_const = import 'earthengine_const.libsonnet';

# TODO(heidichen): Transition this file to the modern versions structure, e.g.
# [
#   {'2.8': 'CSIC/SPEI/2_8'},
#   {'2.9': 'CSIC/SPEI/2_9'},
# ]

# Not all versions are surfaced in the catalog.
local version_table = {
  '2016': 'GLIMS/2016',
  // '20170209': 'GLIMS/20170209',
  '20171027': 'GLIMS/20171027',
  // '20190304': 'GLIMS/20190304',
  // '20191217': 'GLIMS/20191217',
  // '20200630': 'GLIMS/20200630',
  '20210914': 'GLIMS/20210914',
  '20230607': 'GLIMS/20230607'
};
# Does not include GLIMS/current which is the same as the most recent.


local last_index = std.length(version_table) - 1;

local subdir = 'GLIMS';
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

    [if x != 0 then 'predecessor_version']: versions[x - 1],
    [if x != 0 then 'predecessor_id']: version_table[self.predecessor_version],
    [if x != 0 then 'predecessor_basename']: basename(self.predecessor_id),
    [if x != 0 then 'predecessor_url']:
        catalog_subdir_url + self.predecessor_basename + '.json',

    last_index: last_index,
    [if x != last_index then 'successor_version']: versions[x + 1],
    [if x != last_index then 'successor_id']:
        version_table[self.successor_version],
    [if x != last_index then 'successor_basename']: basename(self.successor_id),
    [if x != last_index then 'successor_url']:
        catalog_subdir_url + self.successor_basename + '.json',
  }
  for x in arr
} + {
  catalog_subdir_url: catalog_subdir_url,
  parent_url: catalog_subdir_url + 'catalog.json',
  subdir: subdir,
}
