local id = 'JAXA/GCOM-C/L3/LAND/LST/V1';
local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GCOM-C/SGLI L3 Land Surface Temperature (V1)',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This product is the temperature of terrestrial land surface.

    A newer version [JAXA/GCOM-C/L3/LAND/LST/V3](JAXA_GCOM-C_L3_LAND_LST_V3) is also available
    for this dataset which uses this [algorithm](https://suzaku.eorc.jaxa.jp/GCOM_C/data/product_std.html)
    for processing.

    GCOM-C conducts long-term and continuous global observation and data collection to elucidate the
    mechanism behind fluctuations in radiation budget and carbon cycle needed to make accurate
    projections regarding future temperature rise. At the same time, cooperating with research
    institutions having a climate numerical model, it contributes to reduction of errors in
    temperature rise prediction derived from the climate numerical model and improvement of accuracy
    of prediction of various environmental changes. SGLI mounted on GCOM-C is the succession sensor
    of the Global Imager (GLI) mounted on ADEOS-II (MIDORI II) and is the Imaging Radiometer which
    measures the radiation from near-ultraviolet to thermal infrared region (380 nm-12 um) in 19
    channels. Global observation of once for approximately every two days is possible at
    mid-latitude near Japan by observation width at ground greater than 1,000 km. In addition, SGLI
    realizes high resolution than the similar global sensor and has a polarized observation function
    and a multi-angle observation function.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://gportal.jaxa.jp/gpr/index/eula?lang=en'),
  ],
  keywords: [
    'climate',
    'g_portal',
    'gcom',
    'gcom_c',
    'jaxa',
    'land',
    'land_surface_temperature',
    'lst',
  ],
  providers: [
    ee.producer_provider('Global Change Observation Mission (GCOM)', 'https://suzaku.eorc.jaxa.jp/GCOM/index.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-01T00:00:00Z', '2020-06-28T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ALGORITHM_VERSION',
        description: 'Algorithm version',
        type: ee_const.var_type.string,
      },
      {
        name: 'GRID_INTERVAL',
        description: 'Spatial resolution',
        type: ee_const.var_type.string,
      },
      {
        name: 'GRID_INTERVAL_UNIT',
        description: 'Unit of GRID_INTERVAL',
        type: ee_const.var_type.string,
      },
      {
        name: 'IMAGE_END_TIME',
        description: 'Image acquisition end time',
        type: ee_const.var_type.string,
      },
      {
        name: 'IMAGE_START_TIME',
        description: 'Image acquisition start time',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_RESULT',
        description: 'Good, Fair, Poor, NG',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_UT',
        description: 'Processing time',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_FILENAME',
        description: 'Source filename',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_VERSION',
        description: 'Product version',
        type: ee_const.var_type.string,
      },
      {
        name: 'SATELLITE_DIRECTION',
        description: 'Satellite orbit direction\n\n* A: Nighttime data\n* D: Daytime data',
        type: ee_const.var_type.string,
      },
      {
        name: 'LST_AVE_OFFSET',
        description: 'Offset',
        type: ee_const.var_type.string,
      },
      {
        name: 'LST_AVE_SLOPE',
        description: 'Slope',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'LST_AVE',
        description: 'Temperature of land surface.',
        'gee:units': 'K',
      },
      {
        name: 'LST_QA_flag',
        description: 'LST QA',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Terrain type',
              bit_count: 2,
              values: [
                {
                  description: 'water (land fraction = 0%)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'mostly water (0% < land fraction < 50%)',
                },
                {
                  value: 2,
                  description: 'mostly coastal (50% < land fraction < 100%)',
                },
                {
                  value: 3,
                  description: 'land (land fraction = 100%)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Surface Temperature',
        lookat: {
          lat: 33.33,
          lon: 128.45,
          zoom: 5,
        },
        filter: {
          filter_name: 'DATE_RANGE',
          time_start: '2020-01-01T00:00:00',
          time_end: '2020-02-01T00:00:00',
        },
        image_visualization: {
          band_vis: {
            min: [
              12338.0,
            ],
            max: [
              16830.0,
            ],
            palette: [
              '040274',
              '040281',
              '0502a3',
              '0502b8',
              '0502ce',
              '0502e6',
              '0602ff',
              '235cb1',
              '307ef3',
              '269db1',
              '30c8e2',
              '32d3ef',
              '3be285',
              '3ff38f',
              '86e26f',
              '3ae237',
              'b5e22e',
              'd6e21f',
              'fff705',
              'ffd611',
              'ffb613',
              'ff8b13',
              'ff6e08',
              'ff500d',
              'ff0000',
              'de0101',
              'c21301',
              'a71001',
              '911003',
            ],
            bands: [
              'LST_AVE',
            ],
          },
        },
      },
    ],
    LST_AVE: {
      minimum: 0.0,
      maximum: 65531.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Moriyama, M. (Sep. 2014). GCOM-C1/SGLI Land Surface Temperature Product Algorithm Theoretical
    Basis Document (Version 1). Retrieved from [https://suzaku.eorc.jaxa.jp/GCOM_C/data/ATBD/ver1/LST-ATBD_2014.pdf](https://suzaku.eorc.jaxa.jp/GCOM_C/data/ATBD/ver1/LST-ATBD_2014.pdf)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is free to use without any restrictions (including commercial use). Anyone wishing
    to publish analyzed results or value added data products should properly credit the original
    G-Portal data, e.g., \"PR data by Japan Aerospace Exploration Agency\". For value added data
    products, please indicate the credit of the original G-Portal data, e.g., \"Original data for
    this value added data product was provided by Japan Aerospace Exploration Agency.\"

    See [G-Portal's terms of service (Article 7)](https://gportal.jaxa.jp/gpr/index/eula?lang=en)
    for additional information.
  |||,
}
