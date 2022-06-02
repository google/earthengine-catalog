local id = 'Oxford';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'Oxford/';
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
    ee.link.child_collection('Oxford_MAP_EVI_5km_Monthly', base_url),
    ee.link.child_collection('Oxford_MAP_IGBP_Fractional_Landcover_5km_Annual', base_url),
    ee.link.child_collection('Oxford_MAP_LST_Day_5km_Monthly', base_url),
    ee.link.child_collection('Oxford_MAP_LST_Night_5km_Monthly', base_url),
    ee.link.child_collection('Oxford_MAP_TCB_5km_Monthly', base_url),
    ee.link.child_collection('Oxford_MAP_TCW_5km_Monthly', base_url),
    ee.link.child_collection('Oxford_MAP_accessibility_to_cities_2015_v1_0', base_url),
    ee.link.child_collection('Oxford_MAP_accessibility_to_healthcare_2019', base_url),
    ee.link.child_collection('Oxford_MAP_friction_surface_2015_v1_0', base_url),
    ee.link.child_collection('Oxford_MAP_friction_surface_2019', base_url),
  ],
}
