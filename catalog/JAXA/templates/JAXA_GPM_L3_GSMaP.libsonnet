local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.proprietary;

{
  description_header: |||
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
    to daily precipitation by NOAA/CPC gauge measurement.
  |||,
  description_footer: |||

    This dataset contains provisional products GSMaP_NRT that are
    regularly replaced with updated versions when the GSMaP_MVK data
    become available.
    The products are marked with a metadata property called ''status''.
    When a product is initially made available, the property value
    is ''provisional''. Once a provisional product has been updated
    with the final version, this value is updated to ''permanent''.
    For more information please refer
    [General Documentation](https://eolp.jaxa.jp/GSMaP_Hourly.html)
  |||,
  license: license.id,
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
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0, '2014-03-01T00:00:00Z', null),
  schema: [
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
    {
      name: 'status',
      description: 'Permanent or provisional',
      type: ee_const.var_type.string,
    },
  ],
  gsd: [
    11132.0,
  ],
  bands: [
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
  visualizations: [
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
  bands_range: {
    hourlyPrecipRate: {
      minimum: 0.0,
      maximum: 204.88,
      'gee:estimated_range': true,
    },
    hourlyPrecipRateGC: {
      minimum: 0.0,
      maximum: 200.36,
      'gee:estimated_range': true,
    },
    observationTimeFlag: {
      minimum: -124.72,
      maximum: 16.06,
      'gee:estimated_range': true,
    },
    gaugeQualityInfo: {
      minimum: 0.0,
      maximum: 121.0,
      'gee:estimated_range': true,
    },
  },
  citation: |||
    Kubota, T., K. Aonashi, T. Ushio, S. Shige, Y. N. Takayabu, M. Kachi,
    Y. Arai, T. Tashima, T. Masaki, N. Kawamoto, T. Mega, M. K. Yamamoto,
    A. Hamada, M. Yamaji, G. Liu and R. Oki 2020: Global Satellite Mapping of
    Precipitation (GSMaP) products in the GPM era, Satellite precipitation
    measurement, Springer, https://doi.org/10.1007/978-3-030-24568-9_20.
  |||,
  doi: '10.57746/EO.01gs73bkt358gfpy92y2qns5e9',
  interval: {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  terms_of_use: |||
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
