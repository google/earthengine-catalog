local id = 'gcp-public-data-weathernext';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'gcp-public-data-weathernext/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    WeatherNext is a growing suite of next-generation weather forecasting AI models developed by Google.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_gcp-public-data-weathernext_assets_59572747_4_0', base_url),
    ee.link.child_collection('projects_gcp-public-data-weathernext_assets_126478713_1_0', base_url),
    ee.link.child_collection('projects_gcp-public-data-weathernext_assets_weathernext_2_0_0', base_url),
  ],
}
