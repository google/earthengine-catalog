local id = 'ee-earth-timelapse';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ee-earth-timelapse/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Earth Timelapse',
  description: |||
    Earth Timelapse is a global, zoomable video that lets you see how our planet has changed since 1984.
  |||,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://developers.google.com/earth-engine/timelapse/about',
    contactDisplay: 'earth-timelapse@google.com',
    contactLink: 'mailto:earth-timelapse@google.com'
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_ee-earth-timelapse_assets_annual', base_url),
  ],
}
