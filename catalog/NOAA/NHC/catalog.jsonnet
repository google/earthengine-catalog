local id = 'NOAA/NHC';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/NHC/';
local parent_url = ee_const.catalog_base + 'NOAA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'NHC',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NOAA_NHC_HURDAT2_atlantic', base_url),
    ee.link.child_collection('NOAA_NHC_HURDAT2_pacific', base_url),
  ],
}
