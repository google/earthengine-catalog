local id = 'ornl-mapspace';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ornl-mapspace/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Global POI-based Landuse Datasets generated and shared by the
    [The Geospatial Science and Human Security Division in Oak Ridge National Laboratory](https://mapspace.ornl.gov/).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_ornl-mapspace_assets_grid_3c', base_url),
      ],
}
