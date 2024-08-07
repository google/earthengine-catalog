local id = 'WCMC';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'WCMC/';
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
    ee.link.child_collection('WCMC_WDOECM_current_points', base_url),
    ee.link.child_collection('WCMC_WDOECM_current_polygons', base_url),
    ee.link.child_collection('WCMC_WDPA_current_points', base_url),
    ee.link.child_collection('WCMC_WDPA_current_polygons', base_url),
    ee.link.child_collection('WCMC_biomass_carbon_density_v1_0', base_url),
  ],
}
