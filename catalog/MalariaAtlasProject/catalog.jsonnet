local id = 'MalariaAtlasProject';
local subdir = id;
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local description = importstr 'description.md';
local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + subdir + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: description,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_1km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_1km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_1km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_5km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_5km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Day_5km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_1km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_1km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_1km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_5km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_5km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_LST_Night_5km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_1km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_1km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_1km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_5km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_5km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_EVI_5km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_1km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_1km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_1km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_5km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_5km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCB_5km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_1km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_1km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_1km_Monthly', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_5km_8-Daily', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_5km_Annual', base_url),
    ee.link.child_collection('MalariaAtlasProject_TCW_5km_Monthly', base_url),
  ],
}