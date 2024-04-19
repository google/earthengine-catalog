local id = 'JRC';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'JRC/';
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
    ee.link.child_collection('JRC_D5_EUCROPMAP_V1', base_url),
    ee.link.child_collection('JRC_GFC2020_V1', base_url),
    ee.link.child_collection('JRC_GHSL_P2016_BUILT_LDSMT_GLOBE_V1', base_url),
    ee.link.child_collection('JRC_GHSL_P2016_POP_GPW_GLOBE_V1', base_url),
    ee.link.child_collection('JRC_GHSL_P2016_SMOD_POP_GLOBE_V1', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_POP', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_SMOD', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_BUILT_C', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_BUILT_H', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_BUILT_S', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_BUILT_S_10m', base_url),
    ee.link.child_collection('JRC_GHSL_P2023A_GHS_BUILT_V', base_url),
    ee.link.child_collection('JRC_GSW1_0_GlobalSurfaceWater', base_url),
    ee.link.child_collection('JRC_GSW1_0_Metadata', base_url),
    ee.link.child_collection('JRC_GSW1_0_MonthlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_0_MonthlyRecurrence', base_url),
    ee.link.child_collection('JRC_GSW1_0_YearlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_1_GlobalSurfaceWater', base_url),
    ee.link.child_collection('JRC_GSW1_1_Metadata', base_url),
    ee.link.child_collection('JRC_GSW1_1_MonthlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_1_MonthlyRecurrence', base_url),
    ee.link.child_collection('JRC_GSW1_1_YearlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_2_GlobalSurfaceWater', base_url),
    ee.link.child_collection('JRC_GSW1_2_Metadata', base_url),
    ee.link.child_collection('JRC_GSW1_2_MonthlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_2_MonthlyRecurrence', base_url),
    ee.link.child_collection('JRC_GSW1_2_YearlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_3_GlobalSurfaceWater', base_url),
    ee.link.child_collection('JRC_GSW1_3_Metadata', base_url),
    ee.link.child_collection('JRC_GSW1_3_MonthlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_3_MonthlyRecurrence', base_url),
    ee.link.child_collection('JRC_GSW1_3_YearlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_4_GlobalSurfaceWater', base_url),
    ee.link.child_collection('JRC_GSW1_4_Metadata', base_url),
    ee.link.child_collection('JRC_GSW1_4_MonthlyHistory', base_url),
    ee.link.child_collection('JRC_GSW1_4_MonthlyRecurrence', base_url),
    ee.link.child_collection('JRC_GSW1_4_YearlyHistory', base_url),
    ee.link.child_collection('JRC_GWIS_GlobFire_v2_DailyPerimeters', base_url),
    ee.link.child_collection('JRC_GWIS_GlobFire_v2_FinalPerimeters', base_url),
    ee.link.child_collection('JRC_LUCAS_HARMO_COPERNICUS_POLYGONS_V1_2018', base_url),
    ee.link.child_collection('JRC_LUCAS_HARMO_THLOC_V1', base_url),
  ],
}
