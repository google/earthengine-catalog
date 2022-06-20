local id = 'USGS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/';
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
    ee.link.child_catalog('3DEP', base_url),
    ee.link.child_catalog('GAP', base_url),
    ee.link.child_catalog('GFSAD1000', base_url),
    ee.link.child_catalog('LIMA', base_url),
    ee.link.child_catalog('NLCD_RELEASES', base_url),
    ee.link.child_catalog('WBD', base_url),
    ee.link.child_collection('USGS_GMTED2010', base_url),
    ee.link.child_collection('USGS_GTOPO30', base_url),
    ee.link.child_collection('USGS_NED', base_url),
    ee.link.child_collection('USGS_NLCD', base_url),
    ee.link.child_collection('USGS_SRTMGL1_003', base_url),
  ],
}
