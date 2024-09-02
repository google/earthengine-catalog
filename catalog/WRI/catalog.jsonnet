local id = 'WRI';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'WRI/';
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
    ee.link.child_collection('WRI_Aqueduct_Flood_Hazard_Maps_V2', base_url),
    ee.link.child_collection('WRI_GFW_FORMA_alerts', base_url),
    ee.link.child_collection('WRI_GFW_FORMA_raw_output_firms', base_url),
    ee.link.child_collection('WRI_GFW_FORMA_raw_output_ndvi', base_url),
    ee.link.child_collection('WRI_GFW_FORMA_thresholds', base_url),
    ee.link.child_collection('WRI_GFW_FORMA_vegetation_tstats', base_url),
    ee.link.child_collection('WRI_GPPD_power_plants', base_url),
    ee.link.child_collection('WRI_SBTN_naturalLands_v1', base_url),
  ],
}
