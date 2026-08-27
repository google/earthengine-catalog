local id = 'GLAD';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'GLAD/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GLAD',
  description: importstr 'description.md',
    'gee:publisher': {
      type: 'PUBLISHER',
      link: 'https://glad.umd.edu/',
      contactDisplay: 'glad@umd.edu',
      contactLink: 'mailto:glad@umd.edu'
  }
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
  ],
}
