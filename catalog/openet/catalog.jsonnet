local id = 'openet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'openet/';
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
    ee.link.child_collection('projects_openet_assets_ensemble_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_disalexi_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_eemetric_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_geesebal_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_ptjpl_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_sims_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_ssebop_conus_gridmet_monthly_v2_1', base_url),
    ee.link.child_collection('projects_openet_assets_ensemble_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_disalexi_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_eemetric_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_geesebal_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_ptjpl_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_sims_conus_gridmet_monthly_v2_0', base_url),
    ee.link.child_collection('projects_openet_assets_ssebop_conus_gridmet_monthly_v2_0', base_url),
  ],
}
