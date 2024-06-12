local id = 'NOAA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NOAA/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

local description = importstr 'description.md';
local gsm_description = importstr 'general_satellite_messages_description.md';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: description + gsm_description,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),

    ee.link.child_collection('NOAA_CFSR', base_url),
    ee.link.child_collection('NOAA_GFS0P25', base_url),
    ee.link.child_collection('NOAA_PERSIANN-CDR', base_url),

    ee.link.child_collection('NOAA_CDR_ATMOS_NEAR_SURFACE_V2', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_AOT_V3', base_url),
    ee.link.child_collection('NOAA_CDR_AVHRR_AOT_V4', base_url),
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

    ee.link.child_collection('NOAA_CFSV2_FOR6H', base_url),

    ee.link.child_collection('NOAA_DMSP-OLS_CALIBRATED_LIGHTS_V4', base_url),
    ee.link.child_collection('NOAA_DMSP-OLS_NIGHTTIME_LIGHTS', base_url),

    ee.link.child_collection('NOAA_NGDC_ETOPO1', base_url),

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
    ee.link.child_collection('NOAA_GOES_18_FDCC', base_url),
    ee.link.child_collection('NOAA_GOES_18_FDCF', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPC', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPF', base_url),
    ee.link.child_collection('NOAA_GOES_18_MCMIPM', base_url),
    ee.link.child_collection('NOAA_IBTrACS_v4', base_url),

    ee.link.child_collection(
      'NOAA_NCEP_DOE_RE2_total_cloud_coverage', base_url),

    ee.link.child_collection('NOAA_NHC_HURDAT2_atlantic', base_url),
    ee.link.child_collection('NOAA_NHC_HURDAT2_pacific', base_url),

    ee.link.child_collection('NOAA_NWS_RTMA', base_url),

    ee.link.child_collection('NOAA_VIIRS_001_VNP09GA', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP09H1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP13A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP14A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP15A2H', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP21A1D', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP21A1N', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP22Q2', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP43IA1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP43IA2', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP46A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP46A2', base_url),
    ee.link.child_collection('NOAA_VIIRS_001_VNP64A1', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_ANNUAL_V21', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_ANNUAL_V22', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_MONTHLY_V1_VCMCFG', base_url),
    ee.link.child_collection('NOAA_VIIRS_DNB_MONTHLY_V1_VCMSLCFG', base_url),
  ],
}
