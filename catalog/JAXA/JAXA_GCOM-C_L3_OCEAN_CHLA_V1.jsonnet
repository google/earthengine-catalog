local id = 'JAXA/GCOM-C/L3/OCEAN/CHLA/V1';
local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
  title: 'GCOM-C/SGLI L3 Chlorophyll-a Concentration (V1)',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This product is the concentration of the photosynthetic pigment (chlorophyll-a) in phytoplankton
    in the sea surface layer.

    A newer version [JAXA/GCOM-C/L3/OCEAN/CHLA/V3](JAXA_GCOM-C_L3_OCEAN_CHLA_V3) is also available
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
    'chla',
    'chlorophyll_a',
    'climate',
    'g_portal',
    'gcom',
    'gcom_c',
    'jaxa',
    'ocean',
    'ocean_color',
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
        name: 'CHLA_AVE_OFFSET',
        description: 'Offset',
        type: ee_const.var_type.string,
      },
      {
        name: 'CHLA_AVE_SLOPE',
        description: 'Slope',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'CHLA_AVE',
        description: 'Concentration of the green pigment (chlorophyll-a) in phytoplankton in sea surface layer.',
        'gee:units': 'mg/m^3',
      },
      {
        name: 'CHLA_QA_flag',
        description: 'CHLA QA',
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
        display_name: 'Chlorophyll-a concentration',
        lookat: {
          lat: 33.33,
          lon: 128.45,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              -3000.0,
            ],
            max: [
              4000.0,
            ],
            palette: [
              '3500a8',
              '0800ba',
              '003fd6',
              '00aca9',
              '77f800',
              'ff8800',
              'b30000',
              '920000',
              '880000',
            ],
            bands: [
              'CHLA_AVE',
            ],
          },
        },
      },
    ],
    CHLA_AVE: {
      minimum: 0.0,
      maximum: 4000.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Murakami, H. (Oct. 2018). ATBD of GCOM-C chlorophyll-a concentration algorithm (Version 1).
    Retrieved from [https://suzaku.eorc.jaxa.jp/GCOM_C/data/ATBD/ver1/SGLI_Chla_algorithm_v10.pdf](https://suzaku.eorc.jaxa.jp/GCOM_C/data/ATBD/ver1/SGLI_Chla_algorithm_v10.pdf)
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
