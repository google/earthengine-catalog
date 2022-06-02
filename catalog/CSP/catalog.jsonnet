local id = 'CSP';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'CSP/';
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
    ee.link.child_collection('CSP_ERGo_1_0_Global_ALOS_CHILI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_ALOS_landforms', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_ALOS_mTPI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_ALOS_topoDiversity', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_SRTM_CHILI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_SRTM_landforms', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_SRTM_mTPI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_Global_SRTM_topoDiversity', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_CHILI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_landforms', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_lithology', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_mTPI', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_physioDiversity', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_physiography', base_url),
    ee.link.child_collection('CSP_ERGo_1_0_US_topoDiversity', base_url),
    ee.link.child_collection('CSP_HM_GlobalHumanModification', base_url),
  ],
}
