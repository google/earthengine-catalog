local id = 'CIESIN';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'CIESIN/';
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
    ee.link.child_collection('CIESIN_GPWv411_GPW_Basic_Demographic_Characteristics', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Data_Context', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Land_Area', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Mean_Administrative_Unit_Area', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_National_Identifier_Grid', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Population_Count', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Population_Density', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_UNWPP-Adjusted_Population_Count', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_UNWPP-Adjusted_Population_Density', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Water_Area', base_url),
    ee.link.child_collection('CIESIN_GPWv411_GPW_Water_Mask', base_url),
    ee.link.child_collection('CIESIN_GPWv4_ancillary-data-grids', base_url),
    ee.link.child_collection('CIESIN_GPWv4_population-count', base_url),
    ee.link.child_collection('CIESIN_GPWv4_population-density', base_url),
    ee.link.child_collection('CIESIN_GPWv4_unwpp-adjusted-population-count', base_url),
    ee.link.child_collection('CIESIN_GPWv4_unwpp-adjusted-population-density', base_url),
  ],
}
