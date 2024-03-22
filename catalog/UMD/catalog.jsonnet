local id = 'UMD';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'UMD/';
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
    ee.link.child_collection('UMD_GLAD_PRIMARY_HUMID_TROPICAL_FORESTS_v1', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2013', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2014', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2015', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2015_v1_3', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2016_v1_4', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2017_v1_5', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2018_v1_6', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2019_v1_7', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2020_v1_8', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2021_v1_9', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2022_v1_10', base_url),
    ee.link.child_collection('UMD_hansen_global_forest_change_2023_v1_11', base_url),
  ],
}
