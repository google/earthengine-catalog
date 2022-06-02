local id = 'USGS/GAP';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/GAP/';
local parent_url = ee_const.catalog_base + 'USGS/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GAP',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USGS_GAP_AK_2001', base_url),
    ee.link.child_collection('USGS_GAP_CONUS_2011', base_url),
    ee.link.child_collection('USGS_GAP_HI_2001', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_designation', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_easement', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_fee', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_proclamation', base_url),
    ee.link.child_collection('USGS_GAP_PR_2001', base_url),
  ],
}
