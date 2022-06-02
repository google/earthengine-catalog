local id = 'NASA/GPM_L3';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/GPM_L3/';
local parent_url = ee_const.catalog_base + 'NASA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GPM_L3',
  description: |||
    [Global Precipitation
    Measurement (GPM)](https://www.nasa.gov/mission_pages/GPM/main/index.html)
    datasets.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NASA_GPM_L3_IMERG_MONTHLY_V06', base_url),
    ee.link.child_collection('NASA_GPM_L3_IMERG_V06', base_url),
  ],
}
