local id = 'edf-methanesat-ee';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'edf-methanesat-ee/';
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
    ee.link.child_collection('projects_edf-methanesat-ee_assets_OGIM_current', base_url),
    ee.link.child_collection('projects_edf-methanesat-ee_assets_public-preview_L3concentration', base_url),
    ee.link.child_collection('projects_edf-methanesat-ee_assets_public-preview_L4area', base_url),
    ee.link.child_collection('projects_edf-methanesat-ee_assets_public-preview_L4area_v2', base_url),
    ee.link.child_collection('projects_edf-methanesat-ee_assets_public-preview_L4point', base_url),
  ],
}

