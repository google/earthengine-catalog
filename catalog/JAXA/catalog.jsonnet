local id = 'JAXA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'JAXA/';
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
    ee.link.child_collection('JAXA_ALOS_AVNIR-2_ORI', base_url),
    ee.link.child_collection('JAXA_ALOS_AW3D30_V1_1', base_url),
    ee.link.child_collection('JAXA_ALOS_AW3D30_V2_1', base_url),
    ee.link.child_collection('JAXA_ALOS_AW3D30_V2_2', base_url),
    ee.link.child_collection('JAXA_ALOS_AW3D30_V3_2', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR_YEARLY_FNF', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR_YEARLY_FNF4', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR_YEARLY_SAR', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR_YEARLY_SAR_EPOCH', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR-2_Level2_1_StripMap_202401', base_url),
    ee.link.child_collection('JAXA_ALOS_PALSAR-2_Level2_2_ScanSAR', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LAI_V1', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LAI_V2', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LAI_V3', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LST_V1', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LST_V2', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_LAND_LST_V3', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_CHLA_V1', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_CHLA_V2', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_CHLA_V3', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_SST_V1', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_SST_V2', base_url),
    ee.link.child_collection('JAXA_GCOM-C_L3_OCEAN_SST_V3', base_url),
    ee.link.child_collection('JAXA_GPM_L3_GSMaP_v6_operational', base_url),
    ee.link.child_collection('JAXA_GPM_L3_GSMaP_v6_reanalysis', base_url),
    ee.link.child_collection('JAXA_GPM_L3_GSMaP_v7_operational', base_url),
    ee.link.child_collection('JAXA_GPM_L3_GSMaP_v8_operational', base_url),
  ],
}
