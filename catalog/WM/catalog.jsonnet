local id = 'WM';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'WM/';
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
    ee.link.child_collection('WM_geoLab_geoBoundaries_600_ADM0', base_url),
    ee.link.child_collection('WM_geoLab_geoBoundaries_600_ADM1', base_url),
    ee.link.child_collection('WM_geoLab_geoBoundaries_600_ADM2', base_url),
  ],
}
