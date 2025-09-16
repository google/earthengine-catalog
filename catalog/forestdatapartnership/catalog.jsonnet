local id = 'forestdatapartnership';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'forestdatapartnership/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets shared by the
    [Forest Data Partnership](https://www.forestdatapartnership.org/).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_community_palm_20240312', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_palm_model_2024a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_rubber_model_2024a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_cocoa_model_2024a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_palm_model_2025a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_rubber_model_2025a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_cocoa_model_2025a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_coffee_model_2025a', base_url),
    ee.link.child_collection('projects_forestdatapartnership_assets_community_forests_ForestPersistence_2020', base_url),
  ],
}
