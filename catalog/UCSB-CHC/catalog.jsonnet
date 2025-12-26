local id = 'UCSB-CHC';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'UCSB-CHC/';
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
    ee.link.child_collection('UCSB-CHC_CHIRPS_V3_DAILY_RNL', base_url),
    ee.link.child_collection('UCSB-CHC_CHIRPS_V3_DAILY_SAT', base_url),
    ee.link.child_collection('UCSB-CHC_CHIRPS_V3_PENTAD', base_url),
  ],
}
