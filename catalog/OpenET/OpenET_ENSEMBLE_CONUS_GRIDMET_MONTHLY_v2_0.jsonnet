local id = 'OpenET/ENSEMBLE/CONUS/GRIDMET/MONTHLY/v2_0';
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
  title: 'OpenET CONUS Ensemble Monthly Evapotranspiration v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The OpenET dataset includes satellite-based data on the total amount of
    water that is transferred from the land surface to the atmosphere through
    the process of evapotranspiration (ET). OpenET provides ET data from
    multiple satellite-driven models, and also calculates a single "ensemble
    value" from the model ensemble. The models currently included in the OpenET
    model ensemble are ALEXI/DisALEXI, eeMETRIC, geeSEBAL, PT-JPL, SIMS, and
    SSEBop. The OpenET ensemble ET value is calculated as the mean of the
    ensemble after filtering and removing outliers using the median absolute
    deviation approach. All models currently use Landsat satellite data to
    produce ET data at a pixel size of 30 meters by 30 meters (0.22 acres per
    pixel). The monthly ET dataset provides data on total ET by month as an
    equivalent depth of water in millimeters.

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
  extent: ee.extent(-126.0, 25.0, -66.0, 50.0, '2013-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'build_date',
        description: 'Date assets were built',
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
        name: 'mgrs_tile',
        description: 'MGRS grid zone ID',
        type: ee_const.var_type.string,
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
        name: 'et_ensemble_mad',
        description: |||
          Ensemble ET value, computed as the mean of the ensemble
          after filtering outliers using the median absolute deviation (mad)
        |||,
        'gee:units': units.millimeter,
      },
      {
        name: 'et_ensemble_mad_min',
        description: |||
           The minimum value in the ensemble range, after filtering for
           outliers using the median absolute deviation (mad)
        |||,
        'gee:units': units.millimeter,
      },
      {
        name: 'et_ensemble_mad_max',
        description: |||
           The maximum value in the ensemble range, after filtering for
           outliers using the median absolute deviation (mad)
        |||,
        'gee:units': units.millimeter,
      },
      {
        name: 'et_ensemble_mad_count',
        description: |||
           The number of models used to compute the ensemble ET value, after
           filtering for outliers using the median absolute deviation (mad)
        |||,
      },
      {
        name: 'et_ensemble_mad_index',
        description: |||
           Bitmask indicating which models were included in the ensemble ET
           value, after filtering for outliers using the median absolute
           deviation (mad)
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'DisALEXI included in ensemble',
              first_bit: 0,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'EEMETRIC included in ensemble',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'GEESEBAL included in ensemble',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'PTJPL included in ensemble',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'SIMS included in ensemble',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'SSEBop included in ensemble',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
          ],
          total_bit_count: 6,
        },
      },
      {
        name: 'et_ensemble_sam',
        description:
           'The simple arithmetic mean (sam) of all six models in the OpenET' +
           'model ensemble',
        'gee:units': units.millimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET Ensemble Monthly ET',
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
            bands: ['et_ensemble_mad'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1111/1752-1688.12956',
  'sci:citation': |||
    Melton, F., Huntington, J., Grimm, R., Herring, J., Hall, M., Rollison, D.,
    Erickson, T., Allen, R., Anderson, M., Fisher, J., Kilic, A., Senay, G.,
    volk, J., Hain, C., Johnson, L., Ruhoff, A., Blankenau, P., Bromley, M.,
    Carrara, W., Daudert, B., Doherty, C., Dunkerly, C., Friedrichs, M., Guzman,
    A., Halverson, G., Hansen, J., Harding, J., Kang, Y., Ketchum, D., Minor,
    B., Morton, C., Revelle, P., Ortega-Salazar, S., Ott, T., Ozdogon, M.,
    Schull, M., Wang, T., Yang, Y., Anderson, R., 2021. OpenET: Filling a
    Critical Data Gap in Water Management for the Western United States.
    Journal of the American Water Resources Association, 2021 Nov 2.
    [doi:10.1111/1752-1688.12956](https://doi.org/10.1111/1752-1688.12956)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
