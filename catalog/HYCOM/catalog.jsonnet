local id = 'HYCOM';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'HYCOM/';
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
    ee.link.child_collection('HYCOM_GLBu0_08_sea_surface_elevation', base_url),
    ee.link.child_collection('HYCOM_GLBu0_08_sea_temp_salinity', base_url),
    ee.link.child_collection('HYCOM_GLBu0_08_sea_water_velocity', base_url),
    ee.link.child_collection('HYCOM_sea_surface_elevation', base_url),
    ee.link.child_collection('HYCOM_sea_temp_salinity', base_url),
    ee.link.child_collection('HYCOM_sea_water_velocity', base_url),
  ],
}
