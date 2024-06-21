local id = 'OpenET/GEESEBAL/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';
local version = '2.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'OpenET CONUS geeSEBAL Monthly Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Implementation of geeSEBAL was recently completed within the OpenET
    framework and an overview of the current geeSEBAL version can be found
    in Laipelt et al. (2021), which is based on the original algorithms
    developed by Bastiaanssen et al. (1998). The OpenET geeSEBAL implementation
    uses land surface temperature (LST) data from Landsat Collection 2, in
    addition to NLDAS and gridMET datasets as instantaneous and daily
    meteorological inputs, respectively. The automated statistical algorithm
    to select the hot and cold endmembers is based on a simplified version of
    the Calibration using Inverse Modeling at Extreme Conditions (CIMEC)
    algorithm proposed by Allen et al. (2013), where quantiles of LST and the
    normalized difference vegetation index (NDVI) values are used to select
    endmember candidates in the Landsat domain area. The cold and wet endmember
    candidates are selected in well vegetated areas, while the hot and dry
    endmember candidates are selected in the least vegetated cropland areas.
    Based on the selected endmembers, geeSEBAL assumes that in the cold and
    wet endmember all available energy is converted to latent heat (with high
    rates of transpiration), while in the hot and dry endmember all available
    energy is converted to sensible heat. Finally, estimates of daily
    evapotranspiration are upscaled from instantaneous estimates based on the
    evaporative fraction, assuming it is constant during the daytime without
    significant changes in soil moisture and advection. Based on the results
    from the OpenET Accuracy Assessment and Intercomparison study, the OpenET
    geeSEBAL algorithm was modified as follows: (i) the simplified version of
    CIMEC was improved by using additional filters to select the endmembers,
    including the use of the USDA Cropland Data Layer (CDL) and filters for
    NDVI, LST and albedo; (ii) corrections to LST for endmembers based on
    antecedent precipitation; (iii) definition of NLDAS wind speed thresholds
    to reduce model instability during the atmospheric correction; and, (iv)
    improvements to estimate daily net radiation, using FAO-56 as reference
    (Allen et al., 1998). Overall, geeSEBAL performance is dependent on
    topographic, climate, and meteorological conditions, with higher
    sensitivity and uncertainty related to hot and cold endmember selections
    for the CIMEC automated calibration, and lower sensitivity and uncertainty
    related to meteorological inputs (Laipelt et al., 2021 and Kayser
    et al., 2022). To reduce uncertainties related to complex terrain,
    improvements were added to correct LST and global (incident) radiation on
    the surface (including the environmental lapse rate, elevation slope
    and aspect) to represent the effects of topographic features on the
    model’s endmember selection algorithm and ET estimates.

    [Additional information](https://openetdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'openet',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126, 25, -66, 50, '2013-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'build_date',
        description: 'Date assets were built',
        type: ee_const.var_type.string,
      },
      {
        name: 'cloud_cover_max',
        description: 'Maximum CLOUD_COVER_LAND percent value for Landsat images included in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'collections',
        description: 'List of Landsat collections for Landsat images included in the interpolation',
        type: ee_const.var_type.string,
      },
      {
        name: 'core_version',
        description: 'OpenET core library version',
        type: ee_const.var_type.string,
      },
      {
        name: 'end_date',
        description: 'End date of month',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_band',
        description: 'Band in et_reference_source that contains the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_resample',
        description: 'Spatial interpolation mode to resample daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'et_reference_source',
        description: 'Collection ID for the daily reference ET data',
        type: ee_const.var_type.string,
      },
      {
        name: 'interp_days',
        description: 'Maximum number of days before and after each image date to include in interpolation',
        type: ee_const.var_type.double,
      },
      {
        name: 'interp_method',
        description: 'Method used to interpolate between Landsat model estimates',
        type: ee_const.var_type.string,
      },
      {
        name: 'interp_source_count',
        description: 'Number of available images in the interpolation source image collection for the target month',
        type: ee_const.var_type.double,
      },
      {
        name: 'mgrs_tile',
        description: 'MGRS grid zone ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_name',
        description: 'OpenET model name',
        type: ee_const.var_type.string,
      },
      {
        name: 'model_version',
        description: 'OpenET model version',
        type: ee_const.var_type.string,
      },
      {
        name: 'scale_factor_count',
        description: 'Scaling factor that should be applied to the count band',
        type: ee_const.var_type.double,
      },
      {
        name: 'scale_factor_et',
        description: 'Scaling factor that should be applied to the et band',
        type: ee_const.var_type.double,
      },
      {
        name: 'start_date',
        description: 'Start date of month',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: 'geeSEBAL ET value',
        'gee:units': units.millimeter,
      },
      {
        name: 'count',
        description: 'Number of cloud free values',
        'gee:units': units.count,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET geeSEBAL Monthly ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1400],
            palette: [
              '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b',
              '9fcb51', '80c256', '61b95c', '42b062', '45b677', '49bc8d',
              '4dc2a2', '51c8b8', '55cece', '4db4ba', '459aa7', '3d8094',
              '356681', '2d4c6e',
            ],
            bands: ['et'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1016/j.isprsjprs.2021.05.018',
  'sci:citation': |||
    Laipelt, L., Kayser, R.H.B., Fleischmann, A.S., Ruhoff, A., Bastiaanssen,
    W., Erickson, T.A. and Melton, F., 2021. Long-term monitoring of
    evapotranspiration using the SEBAL algorithm and Google Earth Engine cloud
    computing. ISPRS Journal of Photogrammetry and Remote Sensing, 178,
    pp.81-96.
    [doi:10.1016/j.isprsjprs.2021.05.018](https://doi.org/10.1016/j.isprsjprs.2021.05.018)
  |||,
  'sci:publications': [
    {
      citation: |||
        Bastiaanssen, W.G., Menenti, M., Feddes, R.A. and Holtslag, A.A.M.,
        1998. A remote sensing surface energy balance algorithm for land
        (SEBAL). 1. Formulation. Journal of hydrology, 212, pp.198-212.
        [doi:S0022-1694(98)00253-4](https://doi.org/10.1016/S0022-1694(98)00253-4)
      |||,
    },
    {
      citation: |||
        Kayser, R.H., Ruhoff, A., Laipelt, L., de Mello Kich, E., Roberti, D.
        R., de Arruda Souza, V., Rubert, G.C.D., Collischonn, W. and Neale,
        C.M.U., 2022. Assessing geeSEBAL automated calibration and
        meteorological reanalysis uncertainties to estimate evapotranspiration
        in subtropical humid climates. Agricultural and Forest Meteorology,
        314, p.108775.
        [doi:10.1016/j.agrformet.2021.108775](https://doi.org/10.1016/j.agrformet.2021.108775)
      |||,
    },
    {
      citation: |||
        Allen, R.G., Burnett, B., Kramber, W., Huntington, J., Kjaersgaard, J.,
        Kilic, A., Kelly, C. and Trezza, R., 2013. Automated calibration of the
        metric-landsat evapotranspiration process. JAWRA Journal of the American
        Water Resources Association, 49(3), pp.563-576.
        [doi:10.1111/jawr.12056](https://doi.org/10.1111/jawr.12056)
      |||,
    },
   ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
