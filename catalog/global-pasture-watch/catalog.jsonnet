local id = 'global-pasture-watch';
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
  title: 'Global Pasture Watch',
  description: description,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring',
    contactDisplay: 'Land & Carbon Lab',
    contactLink: 'https://landcarbonlab.org/subscribe'
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_ggc-30m_v1_grassland_c', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_ggc-30m_v1_cultiv-grassland_p', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_ggc-30m_v1_nat-semi-grassland_p', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_ggpp-30m_v1_ugpp_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gsvh-30m_v1_short-veg-height_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gld-1km_v1_cattle-headcount-faostat_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gld-1km_v1_buffalo-headcount-faostat_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gld-1km_v1_goat-headcount-faostat_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gld-1km_v1_horse-headcount-faostat_m', base_url),
    ee.link.child_collection('projects_global-pasture-watch_assets_gld-1km_v1_sheep-headcount-faostat_m', base_url),
  ],
}
