local id = 'OSU';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'OSU/';
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
    ee.link.child_collection('OSU_GIMP_2000_ICE_OCEAN_MASK', base_url),
    ee.link.child_collection('OSU_GIMP_2000_IMAGERY_MOSAIC', base_url),
    ee.link.child_collection('OSU_GIMP_DEM', base_url),
    ee.link.child_collection('OSU_GIMP_ICE_VELOCITY_OPT', base_url),
  ],
}
