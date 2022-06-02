local id = 'NASA/ORNL';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/ORNL/';
local parent_url = ee_const.catalog_base + 'NASA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'ORNL',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NASA_ORNL_DAYMET_V3', base_url),
    ee.link.child_collection('NASA_ORNL_DAYMET_V4', base_url),
    ee.link.child_collection('NASA_ORNL_biomass_carbon_density_v1', base_url),
  ],
}
