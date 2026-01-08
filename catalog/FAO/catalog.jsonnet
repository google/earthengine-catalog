local id = 'FAO';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'FAO/';
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
    ee.link.child_collection('FAO_GAUL_2015_level0', base_url),
    ee.link.child_collection('FAO_GAUL_2015_level1', base_url),
    ee.link.child_collection('FAO_GAUL_2015_level2', base_url),
    ee.link.child_collection('FAO_GAUL_SIMPLIFIED_500m_2015_level0', base_url),
    ee.link.child_collection('FAO_GAUL_SIMPLIFIED_500m_2015_level1', base_url),
    ee.link.child_collection('FAO_GAUL_SIMPLIFIED_500m_2015_level2', base_url),
    ee.link.child_collection('FAO_GHG_1_DROSA_A', base_url),
    ee.link.child_collection('FAO_GHG_1_DROSE_A', base_url),
    ee.link.child_collection('FAO_GHG_1_DROS_A', base_url),
    ee.link.child_collection('FAO_GHG_1_DROS_E', base_url),
    ee.link.child_collection('FAO_SOFO_1_FPP', base_url),
    ee.link.child_collection('FAO_SOFO_1_TPP', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_AETI_D', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_E_D', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_I_D', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_NPP_D', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_RET_D', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_RET_E', base_url),
    ee.link.child_collection('FAO_WAPOR_2_L1_T_D', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_AETI_D', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_E_D', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_I_D', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_RET_D', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_RET_E', base_url),
    ee.link.child_collection('FAO_WAPOR_3_L1_T_D', base_url),

  ],
}
