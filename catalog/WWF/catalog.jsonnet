local id = 'WWF';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'WWF/';
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
    ee.link.child_collection('WWF_HydroSHEDS_03CONDEM', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_03DIR', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_03VFDEM', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_15ACC', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_15CONDEM', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_15DIR', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_30ACC', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_30CONDEM', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_30DIR', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_1', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_10', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_11', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_12', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_2', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_3', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_4', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_5', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_6', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_7', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_8', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_Basins_hybas_9', base_url),
    ee.link.child_collection('WWF_HydroSHEDS_v1_FreeFlowingRivers', base_url),
  ],
}
