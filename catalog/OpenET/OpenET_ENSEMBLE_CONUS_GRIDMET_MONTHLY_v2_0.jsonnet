local id = 'OpenET/ENSEMBLE/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'OpenET CONUS Ensemble Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The OpenET dataset includes satellite-based data on the total amount of water that
    is transferred from the land surface to the atmosphere through the process of
    evapotranspiration (ET). OpenET provides ET data from multiple satellite-driven models,
    and also calculates a single “ensemble value” from the model ensemble. The models
    currently included in the OpenET model ensemble are ALEXI/DisALEXI, eeMETRIC, geeSEBAL,
    PT-JPL, SIMS, and SSEBop. The OpenET ensemble ET value is calculated as the mean of the
    ensemble after filtering and removing outliers using the median absolute
    deviation approach. All of the models included in the OpenET ensemble have been used by
    government agencies with responsibility for water use reporting and management in the
    western United States, and some models are widely used internationally. All models
    currently use Landsat satellite data to produce ET data at a pixel size of
    30 meters by 30 meters (0.22 acres per pixel), with some models incorporating data
    from GOES, Terra, Aqua, Sentinel-2 and other satellites as inputs. Additional model
    inputs include gridded weather variables such as solar radiation, air temperature,
    humidity, and wind speed. The monthly ET dataset provides data on total ET by month as an
    equivalent depth of water in millimeters. Data on daily ET on the dates of satellite overpass
    is available under a separate collection.
    For additional information, please see: https://openetdata.org/methodologies/
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet',
    'landsat',
    'monthly',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126.0, 25.0, -66.0, 50.0, '2016-01-01T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'et_ensemble_mad',
        description: |||
          Ensemble ET value, computed as the mean of the ensemble
          after filtering outliers using the median absolute deviation (mad)
        |||,
        'gee:units': 'mm',
      },
      {
        name: 'et_ensemble_mad_min',
        description: |||
           The minimum value in the ensemble range, after filtering for
           outliers using the median absolute deviation (mad)
        |||,
        'gee:units': 'mm',
      },
      {
        name: 'et_ensemble_mad_max',
        description: |||
           The maximum value in the ensemble range, after filtering for
           outliers using the median absolute deviation (mad)
        |||,
        'gee:units': 'mm',
      },
      {
        name: 'et_ensemble_mad_count',
        description: |||
           The number of models used to compute the ensemble ET value,
           after filtering for outliers using the median absolute deviation (mad)
        |||,
      },
      {
        name: 'et_ensemble_mad_index',
        description: |||
           A bit-encoded index value used to determine which
           individual models were used to compute the ensemble ET value,
           after filtering for outliers using the median absolute deviation (mad);
           Bit 0: DisALEXI; Bit 1: EEMETRIC; Bit 2: GEESEBAL; Bit 3: PTJPL ;Bit 4:
           SIMS; Bit 5: SSEBop
        |||,
      },
      {
        name: 'et_ensemble_sam',
        description: |||
           The simple arithmetic mean (sam) of all six models in the OpenET model ensemble
        |||,
        'gee:units': 'mm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET Ensemble Monthly ET',
        lookat: {
          lat: 38.0,
          lon: -100.0,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1400.0,
            ],
            palette: [
              '9E6212',
              'AC7D1D',
              'BA9829',
              'C8B434',
              'D6CF40',
              'BED44B',
              '9FCB51',
              '80C256',
              '61B95C',
              '42B062',
              '45B677',
              '49BC8D',
              '4DC2A2',
              '51C8B8',
              '55CECE',
              '4DB4BA',
              '459AA7',
              '3D8094',
              '356681',
              '2D4C6E',
            ],
            bands: [
              'et_ensemble_mad',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Melton, F., Huntington, J., Grimm, R., Herring, J., Hall, M., Rollison, D.,
    Erickson, T., Allen, R., Anderson, M., Fisher, J., Kilic, A., Senay, G., volk, J.,
    Hain, C., Johnson, L., Ruhoff, A., Blanenau, P., Bromley, M., Carrara, W., Daudert, B.,
    Doherty, C., Dunkerly, C., Friedrichs, M., Guzman, A., Halverson, G., Hansen, J.,
    Harding, J., Kang, Y., Ketchum, D., Minor, B., Morton, C., Ortega-Salazar, S., Ott, T.,
    Ozdogon, M., Schull, M., Wang, T., Yang, Y., Anderson, R., 2021.
    OpenET: Filling a Critical Data Gap in Water Management for the Western United States.
    Journal of the American Water Resources Association, 2021 Nov 2.
    DOI https://doi.org/10.1111/1752-1688.12956
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
