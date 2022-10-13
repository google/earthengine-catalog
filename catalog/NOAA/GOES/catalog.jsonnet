local id = 'NOAA/GOES';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/GOES/';
local parent_url = ee_const.catalog_base + 'NOAA/catalog.json';
local self_url = base_url + base_filename;

local description = importstr 'description.md';
local gsm_description =
  importstr '../general_satellite_messages_description.md';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GOES',
  description: description + gsm_description,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NOAA_GOES_16_FDCC', base_url),
    ee.link.child_collection('NOAA_GOES_16_FDCF', base_url),
    ee.link.child_collection('NOAA_GOES_16_MCMIPC', base_url),
    ee.link.child_collection('NOAA_GOES_16_MCMIPF', base_url),
    ee.link.child_collection('NOAA_GOES_16_MCMIPM', base_url),
    ee.link.child_collection('NOAA_GOES_17_FDCC', base_url),
    ee.link.child_collection('NOAA_GOES_17_FDCF', base_url),
    ee.link.child_collection('NOAA_GOES_17_MCMIPC', base_url),
    ee.link.child_collection('NOAA_GOES_17_MCMIPF', base_url),
    ee.link.child_collection('NOAA_GOES_17_MCMIPM', base_url),
    // TODO(b/222129714): Enable when available.
    // ee.link.child_collection('NOAA_GOES_18_FDCC', base_url),
    // ee.link.child_collection('NOAA_GOES_18_FDCF', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPC', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPF', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPM', base_url),
  ],
}
