local id = 'NOAA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/';
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
    { rel: 'child', title: 'CDR', href: base_url + 'CDR/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'CFSV2', href: base_url + 'CFSV2/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'DMSP-OLS', href: base_url + 'DMSP-OLS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GOES', href: base_url + 'GOES/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NCEP_DOE_RE2', href: base_url + 'NCEP_DOE_RE2/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NGDC', href: base_url + 'NGDC/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NHC', href: base_url + 'NHC/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NWS', href: base_url + 'NWS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'VIIRS', href: base_url + 'VIIRS/catalog.json', type: ee_const.media_type.stac },
    ee.link.child_collection('NOAA_CFSR', base_url),
    ee.link.child_collection('NOAA_GFS0P25', base_url),
    ee.link.child_collection('NOAA_PERSIANN-CDR', base_url),
  ],
}
