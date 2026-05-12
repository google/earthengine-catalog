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
  title: 'Awesome GEE Community Catalog',
  description: 'The [Awesome GEE Community Catalog](https://gee-community-catalog.org/) is an unfunded open source grassroots project with a mission to help collect community sourced and community generated geospatial datasets. Their goal is to make data accessible and tie it to an analysis platform fostering accessibility and reducing digital divide. This catalog lives and serves alongside the Google Earth Engine data catalog. This collaborative effort not only offers openly available, preprocessed research datasets but also caters to frequently requested ones under various open licenses. You can find the full community catalog and access all datasets [here](https://gee-community-catalog.org/).',
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