local id = 'COPERNICUS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'COPERNICUS/';
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
    ee.link.child_collection('COPERNICUS_CORINE_V18_5_1_100m', base_url),
    ee.link.child_collection('COPERNICUS_CORINE_V20_100m', base_url),
    ee.link.child_collection('COPERNICUS_Landcover_100m_Proba-V-C3_Global', base_url),
    ee.link.child_collection('COPERNICUS_Landcover_100m_Proba-V_Global', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_ANALYSISFORECAST_BGC_001_028_BIO', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_ANALYSISFORECAST_BGC_001_028_CAR', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_ANALYSISFORECAST_BGC_001_028_CO2', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_ANALYSISFORECAST_BGC_001_028_NUT', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_ANALYSISFORECAST_PHY_DAILY', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_SEA_SURFACE_NRT_DAILY', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_GLOBAL_SEA_SURFACE_REP_DAILY', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_OPTICS_MULTI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_PLANKTON_MULTI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_PLANKTON_OLCI_300M', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_PRIMARY_PRODUCTION_MULTI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_REFLECTANCE_MULTI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_REFLECTANCE_OLCI_300M', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_TRANSPARENCY_MULTI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_OC_GLO_BGC_TRANSPARENCY_OLCI_4KM', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_SATELLITE_OCEAN_COLOR_V6', base_url),
    ee.link.child_collection('COPERNICUS_MARINE_WAV_ANFC_0_083DEG_PT3H', base_url),
    ee.link.child_collection('COPERNICUS_S1_GRD', base_url),
    ee.link.child_collection('COPERNICUS_S2', base_url),
    ee.link.child_collection('COPERNICUS_S2_HARMONIZED', base_url),
    ee.link.child_collection('COPERNICUS_S2_CLOUD_PROBABILITY', base_url),
    ee.link.child_collection('COPERNICUS_S2_SR', base_url),
    ee.link.child_collection('COPERNICUS_S2_SR_HARMONIZED', base_url),
    ee.link.child_collection('COPERNICUS_S3_OLCI', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_AER_AI', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_AER_LH', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_CLOUD', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_CO', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_HCHO', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_NO2', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_O3', base_url),
    ee.link.child_collection('COPERNICUS_S5P_NRTI_L3_SO2', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_AER_AI', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_AER_LH', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_CH4', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_CLOUD', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_CO', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_HCHO', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_NO2', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_O3', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_O3_TCL', base_url),
    ee.link.child_collection('COPERNICUS_S5P_OFFL_L3_SO2', base_url),
    ee.link.child_collection('COPERNICUS_DEM_GLO30', base_url),
  ],
}
