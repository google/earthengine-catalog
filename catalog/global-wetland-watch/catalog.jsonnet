local id = 'global-wetland-watch';
local subdir = id;

local description = importstr 'description.md';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + subdir + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Global Wetland Watch',
  description: description,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://www.globalwetlandwatch.org/',
    contactDisplay: 'Global Wetland Watch',
    contactLink: 'https://www.globalwetlandwatch.org/',
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_results_annual_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_results_multiannual_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_features_water_frequency_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_features_hand_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_coastal_tidal_composites_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_coastal_intertidal_frequency_v1', base_url),
    ee.link.child_collection('projects_global-wetland-watch_assets_features_ccdc_palsar2_v1', base_url),
  ],
}
