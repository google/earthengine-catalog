local id = 'USGS/GFSAD1000';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/GFSAD1000/';
local parent_url = ee_const.catalog_base + 'USGS/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GFSAD1000',
  description: |||
    Datasets from the
    [Global Food-Support Analysis Data](https://www.usgs.gov/centers/western-geographic-science-center/science/global-food-security-support-analysis-data-30-m)
    project.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USGS_GFSAD1000_V0', base_url),
    ee.link.child_collection('USGS_GFSAD1000_V1', base_url),
  ],
}
