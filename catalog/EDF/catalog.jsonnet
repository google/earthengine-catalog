local id = 'EDF';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'EDF/';
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
    ee.link.child_collection('EDF_OGIM_OGIM_v2-4_RF06_RF08', base_url),
    ee.link.child_collection('EDF_MethaneSAT_MethaneAIR_methaneair-L4area-2021', base_url),
    ee.link.child_collection('EDF_MethaneSAT_MethaneAIR_methaneair-L4point-2021', base_url),
    ee.link.child_collection('EDF_OGIM_current', base_url),
    ee.link.child_collection('EDF_MethaneSAT_MethaneAIR_L4area', base_url),
    ee.link.child_collection('EDF_MethaneSAT_MethaneAIR_L4point', base_url),
    ee.link.child_collection('EDF_MethaneSAT_MethaneAIR_L3concentration', base_url),
  ],
}

