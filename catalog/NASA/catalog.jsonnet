local id = 'NASA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/';
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

    ee.link.child_collection('NASA_ASTER_GED_AG100_003', base_url),

    ee.link.child_collection('NASA_FLDAS_NOAH01_C_GL_M_V001', base_url),

    ee.link.child_collection('NASA_GDDP-CMIP6', base_url),

    ee.link.child_collection('NASA_GEOS-CF_v1_fcst_htf', base_url),
    ee.link.child_collection('NASA_GEOS-CF_v1_fcst_tavg1hr', base_url),
    ee.link.child_collection('NASA_GEOS-CF_v1_rpl_htf', base_url),
    ee.link.child_collection('NASA_GEOS-CF_v1_rpl_tavg1hr', base_url),

    ee.link.child_collection('NASA_GIMMS_3GV0', base_url),

    ee.link.child_collection('NASA_GLDAS_V021_NOAH_G025_T3H', base_url),
    ee.link.child_collection('NASA_GLDAS_V022_CLSM_G025_DA1D', base_url),
    ee.link.child_collection('NASA_GLDAS_V20_NOAH_G025_T3H', base_url),

    ee.link.child_collection('NASA_GPM_L3_IMERG_MONTHLY_V06', base_url),
    ee.link.child_collection('NASA_GPM_L3_IMERG_V06', base_url),

    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_LAND', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_MASCON', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_MASCON_CRI', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_OCEAN', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_OCEAN_EOFR', base_url),

    ee.link.child_collection('NASA_GSFC_MERRA_aer_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_flx_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_lnd_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_rad_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_slv_2', base_url),
    ee.link.child_collection('NASA_HLS_HLSL30_v002', base_url),

    ee.link.child_collection(
      'NASA_JPL_global_forest_canopy_height_2005', base_url),

    ee.link.child_collection('NASA_MEASURES_GFCC_TC_v3', base_url),

    ee.link.child_collection('NASA_NASADEM_HGT_001', base_url),

    ee.link.child_collection('NASA_NEX-DCP30', base_url),
    ee.link.child_collection('NASA_NEX-DCP30_ENSEMBLE_STATS', base_url),
    ee.link.child_collection('NASA_NEX-GDDP', base_url),

    ee.link.child_collection('NASA_NLDAS_FORA0125_H002', base_url),

    ee.link.child_collection('NASA_OCEANDATA_MODIS-Aqua_L3SMI', base_url),
    ee.link.child_collection('NASA_OCEANDATA_MODIS-Terra_L3SMI', base_url),
    ee.link.child_collection('NASA_OCEANDATA_SeaWiFS_L3SMI', base_url),

    ee.link.child_collection('NASA_ORNL_DAYMET_V3', base_url),
    ee.link.child_collection('NASA_ORNL_DAYMET_V4', base_url),
    ee.link.child_collection('NASA_ORNL_biomass_carbon_density_v1', base_url),

    ee.link.child_collection('NASA_SMAP_SPL4SMGP_007', base_url),
    ee.link.child_collection('NASA_SMAP_SPL3SMP_E_005', base_url)
  ],
}
