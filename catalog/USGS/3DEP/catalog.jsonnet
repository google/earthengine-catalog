local id = 'USGS/3DEP';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/3DEP/';
local parent_url = ee_const.catalog_base + 'USGS/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: '3DEP',
  description: |||
    Datasets from the
    [3D Elevation Program (3DEP)](https://www.usgs.gov/3d-elevation-program).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USGS_3DEP_10m', base_url),
    ee.link.child_collection('USGS_3DEP_10m_metadata', base_url),
  ],
}
