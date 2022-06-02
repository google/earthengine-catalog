local id = 'OpenLandMap';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'OpenLandMap/';
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
    ee.link.child_collection('OpenLandMap_CLM_CLM_LST_MOD11A2-DAYNIGHT_M_v01', base_url),
    ee.link.child_collection('OpenLandMap_CLM_CLM_LST_MOD11A2-DAY_M_v01', base_url),
    ee.link.child_collection('OpenLandMap_CLM_CLM_LST_MOD11A2-DAY_SD_v01', base_url),
    ee.link.child_collection('OpenLandMap_CLM_CLM_PRECIPITATION_SM2RAIN_M_v01', base_url),
    ee.link.child_collection('OpenLandMap_PNV_PNV_BIOME-TYPE_BIOME00K_C_v01', base_url),
    ee.link.child_collection('OpenLandMap_PNV_PNV_FAPAR_PROBA-V_D_v01', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_BULKDENS-FINEEARTH_USDA-4A1H_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_CLAY-WFRACTION_USDA-3A1A1A_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_GRTGROUP_USDA-SOILTAX-HAPLUDALFS_P_v01', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_GRTGROUP_USDA-SOILTAX_C_v01', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_ORGANIC-CARBON_USDA-6A1C_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_PH-H2O_USDA-4C1A2A_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_SAND-WFRACTION_USDA-3A1A1A_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_TEXTURE-CLASS_USDA-TT_M_v02', base_url),
    ee.link.child_collection('OpenLandMap_SOL_SOL_WATERCONTENT-33KPA_USDA-4B1C_M_v01', base_url),
  ],
}
