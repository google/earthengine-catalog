local id = 'malariaatlasproject';
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
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Day_v061_1km_8-Daily', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Day_v061_1km_Annual', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Day_v061_1km_Monthly', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Night_v061_1km_8-Daily', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Night_v061_1km_Annual', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_LST_Night_v061_1km_Monthly', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_EVI_v061_1km_8-Daily', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_EVI_v061_1km_Annual', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_EVI_v061_1km_Monthly', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCB_v061_1km_8-Daily', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCB_v061_1km_Annual', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCB_v061_1km_Monthly', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCW_v061_1km_8-Daily', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCW_v061_1km_Annual', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_TCW_v061_1km_Monthly', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_accessibility_friction_surface_2015_v1_0', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_accessibility_friction_surface_2019_v5_1_walking_only', base_url),
    ee.link.child_collection('projects_malariaatlasproject_assets_accessibility_friction_surface_2019_v5_1', base_url),
  ],
}
