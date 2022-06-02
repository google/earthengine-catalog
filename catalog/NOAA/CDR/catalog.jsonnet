local id = 'NOAA/CDR';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/CDR/';
local parent_url = ee_const.catalog_base + 'NOAA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'CDR',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NOAA_CDR_ATMOS_NEAR_SURFACE_V2', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_AOT_V3', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_LAI_FAPAR_V4', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_LAI_FAPAR_V5', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_NDVI_V4', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_NDVI_V5', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_SR_V4', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_SR_V5', base_url),
    ee.link.child_collection('NOAA_CDR_GRIDSAT-B1_V2', base_url),
    ee.link.child_collection('NOAA_CDR_HEAT_FLUXES_V2', base_url),
    ee.link.child_collection('NOAA_CDR_OISST_V2', base_url),
    ee.link.child_collection('NOAA_CDR_OISST_V2_1', base_url),
    ee.link.child_collection('NOAA_CDR_PATMOSX_V53', base_url),
    ee.link.child_collection('NOAA_CDR_SST_PATHFINDER_V53', base_url),
    ee.link.child_collection('NOAA_CDR_SST_WHOI_V2', base_url),
  ],
}
