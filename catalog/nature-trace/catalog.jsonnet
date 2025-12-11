local id = 'nature-trace';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'nature-trace/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Nature Trace is a growing suite of geospatial layers from next-generation AI models developed by Google DeepMind and Google Research for understanding environments that can support nature.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_nature-trace_assets_forest_typology_natural_forest_2020_v1_0_collection', base_url),
    ee.link.child_collection('projects_nature-trace_assets_farmscapes_england_v1_0', base_url),
    ee.link.child_collection('projects_nature-trace_assets_species_distribution_models_australia_mammals_v0', base_url),
  ],
}
