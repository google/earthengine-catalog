local id = 'NOAA/VIIRS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/VIIRS/';
local parent_url = ee_const.catalog_base + 'NOAA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'VIIRS',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP09GA', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP13A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP14A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP22Q2', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_MONTHLY_V1_VCMCFG', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_MONTHLY_V1_VCMSLCFG', base_url),
  ],
}
