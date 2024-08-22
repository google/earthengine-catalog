local id = 'LARSE';
local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'LARSE/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    [Global Ecosystem Dynamics Investigation (GEDI)](https://gedi.umd.edu/)
    dataset from the [US Forest Service (USFS)](https://www.fs.usda.gov/)
    [Laboratory for Applications of Remote Sensing in
    Ecology (LARSE)](https://www.fs.usda.gov/rmrs/groups/larse).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_A_002', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_A_002_INDEX', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_A_002_MONTHLY', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_B_002', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_B_002_INDEX', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI02_B_002_MONTHLY', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI04_B_002', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI04_A_002', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI04_A_002_INDEX', base_url),
    ee.link.child_collection('LARSE_GEDI_GEDI04_A_002_MONTHLY', base_url),
    ee.link.child_collection('LARSE_GEDI_GRIDDEDVEG_002_V1_12KM', base_url),
    ee.link.child_collection('LARSE_GEDI_GRIDDEDVEG_002_V1_1KM', base_url),
    ee.link.child_collection('LARSE_GEDI_GRIDDEDVEG_002_V1_6KM', base_url),
  ],
}
