local id = 'JAXA/GPM_L3/GSMaP/v6/reanalysis';
local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'GSMaP Reanalysis: Global Satellite Mapping of Precipitation',
  version: 'v6',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Global Satellite Mapping of Precipitation (GSMaP) provides
    a global hourly rain rate with a 0.1 x 0.1 degree resolution. GSMaP
    is a product of the Global Precipitation Measurement (GPM) mission,
    which provides global precipitation observations at three hour
    intervals.  Values are estimated using multi-band passive microwave
    and infrared radiometers from the GPM Core Observatory satellite
    and with the assistance of a constellation of other satellites.  GPM's
    precipitation rate retrieval algorithm is based on a radiative
    transfer model. The gauge-adjusted rate is calculated based on
    the optimization of the 24h accumulation of GSMaP hourly rain rate
    to daily precipitation by NOAA/CPC gauge measurement. This dataset
    is processed by GSMaP algorithm version 6 (product version 3).
    See [GSMaP Technical Documentation](https://www.eorc.jaxa.jp/GPM/doc/algorithm/GSMaPforGPM_20140902_E.pdf)
    for more details.

    The operational GSMaP dataset (from 2014 to present)
    is also [available](JAXA_GPM_L3_GSMaP_v6_operational].
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'geophysical',
    'gpm',
    'hourly',
    'jaxa',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider('JAXA Earth Observation Research Center', 'https://sharaku.eorc.jaxa.jp/GSMaP/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0,
                    '2000-03-01T00:00:00Z', '2014-03-12T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'AlgorithmID',
        description: 'The algorithm that generated this product, e.g., 3GSMAPH',
        type: ee_const.var_type.string,
      },
      {
        name: 'AlgorithmVersion',
        description: 'The version of the algorithm that generated this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'ProductVersion',
        description: 'The data version assigned by the processing system',
        type: ee_const.var_type.string,
      },
      {
        name: 'GenerationDateTime',
        description: 'The date and time this granule was generated',
        type: ee_const.var_type.string,
      },
      {
        name: 'StartGranuleDateTime',
        description: 'The start time defining this granule',
        type: ee_const.var_type.string,
      },
      {
        name: 'StopGranuleDateTime',
        description: 'The stop time defining this granule',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: 'satelliteInfoFlag',
        description: 'Satellite/sensor used',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'NOAA/CPC Globally Merged IR data',
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'TRMM/TMI',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'GPM-Core/GMI',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Megha-Tropiques/MADRAS',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Megha-Tropiques/SAPHIR',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'ADEOS-II/AMSR',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Aqua/AMSR-E',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'GCOM-W1/AMSR2',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'GCOM-W2/AMSR2',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'GCOM-W3/AMSR2',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F11/SSM/I',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F13/SSM/I',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F14/SSM/I',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F15/SSM/I',
              first_bit: 13,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F16/SSM/I',
              first_bit: 14,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F17/SSM/I',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F18/SSM/I',
              first_bit: 16,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F19/SSM/I',
              first_bit: 17,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'DMSP-F20/SSM/I',
              first_bit: 18,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NOAA-15/AMSU-A/B',
              first_bit: 19,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NOAA-16/AMSU-A/B',
              first_bit: 20,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NOAA-17/AMSU-A/B',
              first_bit: 21,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NOAA-18/AMSU-A/B',
              first_bit: 22,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NOAA-19/AMSU-A/B',
              first_bit: 23,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'NPP/ATMS',
              first_bit: 24,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'JPSS-1/ATMS',
              first_bit: 25,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'MetOp-A/AMSU-A/MHS',
              first_bit: 26,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'MetOp-B/AMSU-A/MHS',
              first_bit: 27,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'MetOp-C/AMSU-A/MHS',
              first_bit: 28,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
          ],
          total_bit_count: 29,
        },
      },
      {
        name: 'hourlyPrecipRate',
        description: 'Snapshot of hourly precipitation rate',
        'gee:units': 'mm/hr',
      },
      {
        name: 'hourlyPrecipRateGC',
        description: 'Snapshot of hourly precipitation rate adjusted to rain gauge',
        'gee:units': 'mm/hr',
      },
      {
        name: 'observationTimeFlag',
        description: |||
          Relative time from the starting time of the file
          to the time of microwave radiometer (imager/sounder) observing.
          If no observation exists within the hourly window, the time
          will be the negative number of hours since the last observation.
        |||,
        'gee:units': units.hour,
      },
      {
        name: 'gaugeQualityInfo',
        description: |||
          Existence of gauge adjustment when the status is
          'provisional', 1 indicates adjusted and 0 is non-adjusted.
          When the status is 'permanent', the pixel value is the daily
          average of number of gauges used for adjustment in the pixel.
        |||,
        'gee:units': units.count_per_day,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 26.12,
          lon: -90.7,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30.0,
            ],
            palette: [
              '1621a2',
              'ffffff',
              '03ffff',
              '13ff03',
              'efff00',
              'ffb103',
              'ff2300',
            ],
            bands: [
              'hourlyPrecipRate',
            ],
          },
        },
      },
    ],
    hourlyPrecipRate: {
      minimum: 0.0,
      maximum: 200.31,
      'gee:estimated_range': true,
    },
    hourlyPrecipRateGC: {
      minimum: 0.0,
      maximum: 200.0,
      'gee:estimated_range': true,
    },
    observationTimeFlag: {
      minimum: -72.52,
      maximum: 14.97,
      'gee:estimated_range': true,
    },
    gaugeQualityInfo: {
      minimum: 0.0,
      maximum: 82.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Kubota, T., K. Aonashi, T. Ushio, S. Shige, Y. N. Takayabu, M. Kachi,
    Y. Arai, T. Tashima, T. Masaki, N. Kawamoto, T. Mega, M. K. Yamamoto,
    A. Hamada, M. Yamaji, G. Liu and R. Oki 2020: Global Satellite Mapping of
    Precipitation (GSMaP) products in the GPM era, Satellite precipitation
    measurement, Springer, https://doi.org/10.1007/978-3-030-24568-9_20.
  |||,
  'sci:doi': '10.57746/EO.01gs73bkt358gfpy92y2qns5e9',
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Anyone wishing to publish any results using the data
    from the JAXA Global Rainfall Watch System should clearly acknowledge
    the ownership of the data in the publication (for example, ' Global
    Rainfall Map in Near-Real-Time (GSMaP_NRT) by JAXA Global Rainfall
    Watch' was produced and distributed by the Earth Observation Research
    Center, Japan Aerospace Exploration Agency). If you have benefited
    from GSMaP rainfall products, please cite the major papers listed
    below. For additional information, please visit the [JAXA Site
    Policy](https://global.jaxa.jp/policy.html) and the [Users Guide](https://sharaku.eorc.jaxa.jp/GSMaP/guide.html).
  |||,
}
