local id = 'ESA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ESA/';
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
    ee.link.child_collection('ESA_CCI_FireCCI_5_1', base_url),
    ee.link.child_collection('ESA_GLOBCOVER_L4_200901_200912_V2_3', base_url),
    ee.link.child_collection('ESA_WorldCover_v100', base_url),
  ],
}
