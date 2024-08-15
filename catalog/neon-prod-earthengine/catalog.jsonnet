local id = 'neon-prod-earthengine';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'neon-prod-earthengine/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets shared by the
    [The U.S. National Science Foundation's National Ecological Observatory Network (NEON)](https://www.neonscience.org/data-collection/airborne-remote-sensing).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_neon-prod-earthengine_assets_CHM_001', base_url),
    ee.link.child_collection('projects_neon-prod-earthengine_assets_DEM_001', base_url),
    ee.link.child_collection('projects_neon-prod-earthengine_assets_HSI_REFL_001', base_url),
    ee.link.child_collection('projects_neon-prod-earthengine_assets_HSI_REFL_002', base_url),
    ee.link.child_collection('projects_neon-prod-earthengine_assets_RGB_001', base_url),
  ],
}
