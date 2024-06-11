local id = 'OpenET/DISALEXI/CONUS/GRIDMET/MONTHLY/v2_0';
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
  title: 'OpenET CONUS DisALEXI Monthly Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Atmosphere-Land Exchange Inverse / Disaggregation of the Atmosphere-Land
    Exchange Inverse (ALEXI/DisALEXI)

    DisALEXI was recently ported to Google Earth Engine as part of the OpenET
    framework and the baseline ALEXI/DisALEXI model structure is described by
    Anderson et al. (2012, 2018). The ALEXI evapotranspiration (ET) model
    specifically uses time differential land surface temperature (LST)
    measurements from geostationary or moderate resolution polar orbiting
    platforms to generate regional ET maps. DisALEXI then disaggregates the
    regional ALEXI ET to finer scales using Landsat data (30 m; biweekly) to
    resolve individual farm fields and other landscape features.
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
        description: 'DisALEXI ET value',
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
        display_name: 'OpenET DisALEXI Monthly ET',
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
  'sci:doi': '10.3390/rs10060889',
  'sci:citation': |||
    Anderson, M., Gao, F., Knipper, K., Hain, C., Dulaney, W., Baldocchi, D .,
    Eichelmann, E., Hemes, K., Yang, Y., Medellin-Azuara, J. and Kustas, W.,
    2018. Field-scale assessment of land and water use change over the
    California Delta using remote sensing. Remote Sensing, 10(6), p.889.
    [doi:10.3390/rs10060889](https://doi.org/10.3390/rs10060889)
  |||,
  'sci:publications': [
    {
      citation: |||
        Anderson, M.C., Norman, J.M., Mecikalski, J.R., Otkin, J.A. and Kustas,
        W.P., 2007. A climatological study of evapotranspiration and moisture
        stress across the continental United States based on thermal remote
        sensing: 1. Model formulation. Journal of Geophysical Research:
        Atmospheres, 112(D10).
        [doi:10.1029/2006JD007506](https://doi.org/10.1029/2006JD007506)
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
