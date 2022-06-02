local id = 'USGS/WBD';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/WBD/';
local parent_url = ee_const.catalog_base + 'USGS/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'WBD',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USGS_WBD_2017_HUC02', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC04', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC06', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC08', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC10', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC12', base_url),
  ],
}
