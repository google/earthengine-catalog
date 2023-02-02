local id = 'ECMWF';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ECMWF/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('ECMWF_CAMS_NRT', base_url),
    ee.link.child_collection('ECMWF_ERA5_DAILY', base_url),
    ee.link.child_collection('ECMWF_ERA5_LAND_DAILY_RAW', base_url),
    ee.link.child_collection('ECMWF_ERA5_LAND_HOURLY', base_url),
    ee.link.child_collection('ECMWF_ERA5_LAND_MONTHLY', base_url),
    ee.link.child_collection('ECMWF_ERA5_LAND_MONTHLY_AGGR', base_url),
    ee.link.child_collection('ECMWF_ERA5_LAND_MONTHLY_BY_HOUR', base_url),
    ee.link.child_collection('ECMWF_ERA5_MONTHLY', base_url),
  ],
}
