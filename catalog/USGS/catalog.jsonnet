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
    { rel: 'child', title: '3DEP', href: base_url + '3DEP/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GAP', href: base_url + 'GAP/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GFSAD1000', href: base_url + 'GFSAD1000/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'LIMA', href: base_url + 'LIMA/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NLCD_RELEASES', href: base_url + 'NLCD_RELEASES/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'WBD', href: base_url + 'WBD/catalog.json', type: ee_const.media_type.stac },
    ee.link.child_collection('USGS_GMTED2010', base_url),
    ee.link.child_collection('USGS_GTOPO30', base_url),
    ee.link.child_collection('USGS_NED', base_url),
    ee.link.child_collection('USGS_NLCD', base_url),
    ee.link.child_collection('USGS_SRTMGL1_003', base_url),
  ],
}
