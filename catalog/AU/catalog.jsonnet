local id = 'AU';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'AU/';
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
    ee.link.child_collection('AU_GA_AUSTRALIA_5M_DEM', base_url),
    ee.link.child_collection('AU_GA_DEM_1SEC_v10_DEM-H', base_url),
    ee.link.child_collection('AU_GA_DEM_1SEC_v10_DEM-S', base_url),
  ],
}
