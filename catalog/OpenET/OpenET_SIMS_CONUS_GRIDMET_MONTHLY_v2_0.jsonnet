local id = 'OpenET/SIMS/CONUS/GRIDMET/MONTHLY/v2_0';
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
  title: 'OpenET CONUS SIMS Monthly Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Satellite Irrigation Management Support

    The NASA Satellite Irrigation Management Support (SIMS) model was originally
    developed to support satellite mapping of crop coefficients and
    evapotranspiration (ET) from irrigated lands and to increase access to this
    data to support use in irrigation scheduling and regional assessment of
    agricultural water needs (Melton et al., 2012). SIMS uses a reflectance
    based approach and incorporates the density coefficient described by Allen
    and Pereira (2009) and Pereira et al. (2020) to compute basal crop
    coefficients for each 30 x 30 m pixel. The primary change from the most
    recent SIMS publication (Pereira et al., 2020) for implementation in OpenET
    is the integration of a gridded soil water balance model to account for soil
    evaporation following precipitation events. Results of the OpenET Phase I
    intercomparison and accuracy assessment (Melton et al., 2022) showed that
    SIMS generally performed well for cropland sites during the growing season,
    but had a persistent low bias during the winter months or other time periods
    with frequent precipitation. This result was anticipated, since the
    reflectance-based approach used by SIMS is not sensitive to soil
    evaporation. To correct for this underestimation, a soil water balance model
    based on FAO-56 (Allen et al., 1998) was implemented on Google Earth Engine
    and driven with gridded precipitation data from gridMET to estimate soil
    evaporation coefficients. These coefficients were then combined with the
    basal crop coefficients calculated by SIMS to calculate total crop
    evapotranspiration using the dual crop coefficient approach. In addition,
    a modest positive bias was observed in the SIMS data for periods with low
    or sparse vegetative cover. To correct for this bias, updates were made to
    the equations that calculate the minimum basal crop coefficient to allow
    lower minimum basal crop coefficient values to be achieved. Full
    documentation of the SIMS model, current algorithms, and details and
    equations used in the soil water balance model are included in the
    SIMS user manual.

    The SIMS model calculates ET under well-watered conditions for the current
    crop growth stage and condition as measured by the satellite data, and SIMS
    is generally expected to have a positive bias for deficit irrigated crops
    and croplands with short-term or intermittent crop water stress. At
    present, SIMS is only implemented for croplands, and non-agricultural lands
    are masked out in this data collection. Future research will extend the
    vegetation density-crop coefficient approach used within SIMS to other land
    cover types.
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
    'water'
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
        description: 'SIMS ET value',
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
        display_name: 'OpenET SIMS Monthly ET',
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
  'sci:doi': '10.1111/1752-1688.12956',
  'sci:citation': |||
    Melton, F., Huntington, J., Grimm, R., Herring, J., Hall, M., Rollison, D.,
    Erickson, T., Allen, R., Anderson, M., Fisher, J., Kilic, A., Senay, G.,
    volk, J., Hain, C., Johnson, L., Ruhoff, A., Blanenau, P., Bromley, M.,
    Carrara, W., Daudert, B., Doherty, C., Dunkerly, C., Friedrichs, M., Guzman,
    A., Halverson, G., Hansen, J., Harding, J., Kang, Y., Ketchum, D., Minor,
    B., Morton, C., Revelle, P., Ortega-Salazar, S., Ott, T., Ozdogon, M.,
    Schull, M., Wang, T., Yang, Y., Anderson, R., 2021. "OpenET: Filling a
    Critical Data Gap in Water Management for the Western United
    States. "Journal of the American Water Resources Association, 58(6),
    pp.971-994.
    [doi:10.1111/1752-1688.12956](https://doi.org/10.1111/1752-1688.12956)
   |||,
   'sci:publications': [
     {
       citation: |||
         Pereira, L.S., P. Paredes, F.S. Melton, L.F. Johnson, R. López-Urrea,
         J. Cancela, and R.G. Allen. 2020. "Prediction of Basal Crop
         Coefficients from Fraction of Ground Cover and Height."  Agricultural
         Water Management, Special Issue on Updates to the FAO56 Crop Water
         Requirements Method 241, 106197.
         [doi:10.1016/j.agwat.2020.106197](https://doi.org/10.1016/j.agwat.2020.106197)
       |||,
      },
     {
       citation: |||
         Melton, F.S., L.F. Johnson, C.P. Lund, L.L. Pierce, A.R. Michaelis,
         S.H. Hiatt, A. Guzman et al. 2012. "Satellite Irrigation Management
         Support with the Terrestrial Observation and Prediction System: A
         Framework for Integration of Satellite and Surface Observations to
         Support Improvements in Agricultural Water Resource Management.IEEE
         Journal of Selected Topics in Applied Earth Observations and Remote
         Sensing 5 (6): 1709–21.
         [doi:10.1109/JSTARS.2012.2214474](https://doi.org/10.1109/JSTARS.2012.2214474)
       |||,
     },
     {
       citation: |||
         Allen, R.G. and Pereira, L.S., 2009. Estimating crop coefficients from
         fraction of ground cover and height. Irrigation Science, 28, pp.17-34.
         [doi:10.1007/s00271-009-0182-z](https://doi.org/10.1007/s00271-009-0182-z)
       |||,
     },
     {
       citation: |||
         Allen, R.G., Pereira, L.S., Raes, D. and Smith, M., 1998. Crop
         evapotranspiration-Guidelines for computing crop water requirements-FAO
         Irrigation and drainage paper 56. Fao, Rome, 300 (9), p.D05109.
         [https://www.fao.org/3/x0490e/x0490e00.htm](https://www.fao.org/3/x0490e/x0490e00.htm)
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
