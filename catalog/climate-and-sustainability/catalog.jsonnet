local id = 'climate-and-sustainability';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + id + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Climate and Sustainability',
  description: |||
    Geospatial datasets from the Climate and Sustainability team at Google
    Research.
  |||,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://research.google/teams/climate-and-sustainability/',
    contactDisplay: 'eoscience-eng@google.com',
    contactLink: 'mailto:eoscience-eng@google.com',
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
  ],
}
