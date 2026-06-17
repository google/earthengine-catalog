local id = 'TIGER';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'TIGER/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('TIGER_2010_BG', base_url),
    ee.link.child_collection('TIGER_2010_Blocks', base_url),
    ee.link.child_collection('TIGER_2010_Tracts_DP1', base_url),
    ee.link.child_collection('TIGER_2010_ZCTA5', base_url),
    ee.link.child_collection('TIGER_2016_Counties', base_url),
    ee.link.child_collection('TIGER_2016_Roads', base_url),
    ee.link.child_collection('TIGER_2016_States', base_url),
    ee.link.child_collection('TIGER_2018_Counties', base_url),
    ee.link.child_collection('TIGER_2018_States', base_url),
    ee.link.child_collection('TIGER_2020_BG', base_url),
    ee.link.child_collection('TIGER_2020_TABBLOCK20', base_url),
    ee.link.child_collection('TIGER_2020_TRACT', base_url),
    ee.link.child_collection('TIGER_2020_ZCTA5', base_url),
  ],
}
