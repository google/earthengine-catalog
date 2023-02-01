local id = 'USGS/NLCD_RELEASES';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/NLCD_RELEASES/';
local parent_url = ee_const.catalog_base + 'USGS/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'NLCD_RELEASES',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2016_REL', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2019_REL_NLCD', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2019_REL_RCMAP_V4_COVER', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2019_REL_RCMAP_V5_COVER', base_url),
  ],
}
