local id = 'ISDASOIL';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ISDASOIL/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets from [iSDAsoil](https://isda-africa.com/).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_aluminium_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_bedrock_depth', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_bulk_density', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_calcium_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_carbon_organic', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_carbon_total', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_cation_exchange_capacity', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_clay_content', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_fcc', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_iron_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_magnesium_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_nitrogen_total', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_ph', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_phosphorus_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_potassium_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_sand_content', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_silt_content', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_stone_content', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_sulphur_extractable', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_texture_class', base_url),
    ee.link.child_collection('ISDASOIL_Africa_v1_zinc_extractable', base_url),
  ],
}
