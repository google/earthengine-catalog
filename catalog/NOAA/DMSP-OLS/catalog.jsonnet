local id = 'NOAA/DMSP-OLS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/DMSP-OLS/';
local parent_url = ee_const.catalog_base + 'NOAA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'DMSP-OLS',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NOAA_DMSP-OLS_CALIBRATED_LIGHTS_V4', base_url),
    ee.link.child_collection('NOAA_DMSP-OLS_NIGHTTIME_LIGHTS', base_url),
  ],
}
