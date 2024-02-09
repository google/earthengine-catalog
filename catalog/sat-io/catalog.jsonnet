local id = 'sat-io';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'sat-io/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    [Awesome GEE Community Catalog](https://gee-community-catalog.org/) consists
    of community-sourced geospatial datasets made available for use by the
    larger Google Earth Engine community and shared publicly as Earth Engine
    assets. The project was started with the idea that a lot of research
    datasets are often unavailable for direct use and require preprocessing
    before use and houses datasets that are often requested by the community and
    under a variety of open licenses.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection(
        'projects_sat-io_open-datasets_GLOBathy_GLOBathy_bathymetry', base_url),
    ee.link.child_collection(
        'projects_sat-io_open-datasets_ORNL_LANDSCAN_GLOBAL', base_url),
    ee.link.child_collection(
        'projects_sat-io_open-datasets_us-drought-monitor', base_url),
  ],
}