local id = 'OpenET';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'OpenET/';
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
    ee.link.child_collection('OpenET_ENSEMBLE_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_DISALEXI_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_EEMETRIC_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_GEESEBAL_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_PTJPL_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_SIMS_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_SSEBOP_CONUS_GRIDMET_MONTHLY_v2_0', base_url),
    ee.link.child_collection('OpenET_REFERENCE_ET_GRIDMET_DAILY_v1_0', base_url),
    ee.link.child_collection('OpenET_REFERENCE_ET_GRIDMET_MONTHLY_v1_0', base_url)
  ]
}
