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
    [The awesome-gee-community-catalog](https://gee-community-catalog.org/)
    consists of community sourced geospatial datasets made available for use by the larger Google Earth Engine community and shared publicly as Earth Engine assets. The project was started with the idea that a lot of research datasets are often unavailable for direct use and require preprocessing before use. This catalog lives and serves alongside the Google Earth Engine data catalog and also houses datasets that are often requested by the community and under a variety of open license.

    You can read about the history and how this project started in the
    [Medium Post article here](https://medium.com/geospatial-processing-at-scale/community-datasets-data-commons-in-google-earth-engine-8585d8baef1f)
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    // TODO: uncomment when the dataset is ready
    // ee.link.child_collection('projects_sat-io_open-datasets_ORNL_LANDSCAN_GLOBAL', base_url),
  ],
}
