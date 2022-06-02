local id = 'LANDFIRE';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'LANDFIRE/';
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
    ee.link.child_collection('LANDFIRE_Fire_FRG_v1_2_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_MFRI_v1_2_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_PLS_v1_2_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_PMS_v1_2_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_PRS_v1_2_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_SClass_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_VCC_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Fire_VDep_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_BPS_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_ESP_v1_2_0_AK', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_ESP_v1_2_0_CONUS', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_ESP_v1_2_0_HI', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_EVC_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_EVH_v1_4_0', base_url),
    ee.link.child_collection('LANDFIRE_Vegetation_EVT_v1_4_0', base_url),
  ],
}
