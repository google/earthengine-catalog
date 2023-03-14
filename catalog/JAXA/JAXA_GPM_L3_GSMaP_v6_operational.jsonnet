local id = 'JAXA/GPM_L3/GSMaP/v6/operational';
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
  title: 'GSMaP Operational: Global Satellite Mapping of Precipitation',
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

    This dataset contains provisional products GSMaP_NRT that are
    regularly replaced with updated versions when the GSMaP_MVK data
    become available.
    The products are marked with a metadata property called ''status''.
    When a product is initially made available, the property value
    is ''provisional''. Once a provisional product has been updated
    with the final version, this value is updated to ''permanent''.

    GSMaP for the reanalysis data (from 2000 to 2014) is also provided
    in the [GPM RNL collection][JAXA_GPM_L3_GSMaP_v6_reanalysis].
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
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0, '2014-03-01T00:00:00Z', null),
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
      {
        name: 'status',
        description: 'Permanent or provisional',
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
        'gee:units': 'counts/day',
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
  'sci:citation': |||
    K. Okamoto, T. Iguchi, N. Takahashi, K. Iwanami and T. Ushio,
    2005: The global satellite mapping of precipitation (GSMaP) project,
    25th IGARSS Proceedings, pp. 3414-3416.
  |||,
  'sci:publications': [
    {
      citation: |||
        T. Kubota, S. Shige, H. Hashizume, K. Aonashi, N. Takahashi, S.
        Seto, M. Hirose, Y. N. Takayabu, K. Nakagawa, K. Iwanami, T. Ushio,
        M. Kachi, and K. Okamoto, 2007: Global Precipitation Map using
        Satelliteborne Microwave Radiometers by the GSMaP Project : Production
        and Validation, IEEE Trans. Geosci. Remote Sens., Vol. 45, No.
        7, pp.2259-2275.
      |||,
    },
    {
      citation: |||
        K. Aonashi, J. Awaka, M. Hirose, T. Kozu, T. Kubota, G. Liu, S.
        Shige, S., Kida, S. Seto, N.Takahashi, and Y. N. Takayabu, 2009:
        GSMaP passive, microwave precipitation retrieval algorithm: Algorithm
        description and validation. J. Meteor. Soc. Japan, 87A, 119-136.
      |||,
    },
    {
      citation: |||
        T. Ushio, T. Kubota, S. Shige, K. Okamoto, K. Aonashi, T. Inoue,
        N., Takahashi, T. Iguchi, M.Kachi, R. Oki, T. Morimoto, and Z.
        Kawasaki, 2009: A Kalman filter approach to the Global Satellite
        Mapping of Precipitation (GSMaP) from combined passive microwave
        and infrared radiometric data. J. Meteor. Soc. Japan, 87A, 137-151.
      |||,
    },
    {
      citation: |||
        S. Shige, T. Yamamoto, T. Tsukiyama, S. Kida, H. Ashiwake, T.
        Kubota, S. Seto, K. Aonashi and K. Okamoto, 2009: The GSMaP precipitation
        retrieval algorithm for microwave sounders. Part I: Over-ocean
        algorithm. IEEE Trans. Geosci. Remote Sens, 47, 3084-3097.
      |||,
    },
    {
      citation: |||
        M. Kachi, T. Kubota, T. Ushio, S. Shige, S. Kida, K. Aonashi,
        and K. Okamoto, 2011: Development and utilization of ''JAXA Global
        Rainfall Watch'' system. IEEJ Transactions on Fundamentals and
        Materials, 131, 729-737. (In Japanese).
      |||,
    },
    {
      citation: |||
        T. Ushio, and M. Kachi, 2009: Kalman filtering application for
        the Global Satellite Mapping of Precipitation (GSMaP). Chapter
        for ''Satellite Rainfall Applications for Surface Hydrology'' (Editedy
        by Mekonnen Gebremichael and Faisal Hossain), Springer, ISBN978-9048129140,
        105-123.
      |||,
    },
    {
      citation: |||
        S. Seto, N. Takahashi, T. Iguchi, 2005: Rain/no-rain classification
        methods for microwave radiometer observations over land using statistical
        information for brightness temperatures under no-rain conditions.
        J. Appl. Meteor., 44, 8, 1243-1259.
      |||,
    },
    {
      citation: |||
        Y. N.Takayabu, 2006: Rain-yield per flash calculated from TRMM
        PR and LIS data and its relationship to the contribution of tall
        convective rain, Geophys. Res. Lett., 33, L18705, doi:10.1029/2006GL027531
      |||,
      doi: '10.1029/2006GL027531',
    },
    {
      citation: |||
        T. Ushio, D. Katagami, K. Okamoto, and T. Inoue, 2007: On the
        use of split window data in deriving the cloud motion vector for
        filling the gap of passive microwave rainfall estimation, SOLA,
        Vol. 3, 001-004, doi:10.2151/sola, February 2007-001.
      |||,
      doi: '10.2151/sola',
    },
    {
      citation: |||
        N. Takahashi, and J. Awaka, 2007: Introduction of a melting layer
        model to a rain retrieval algorithm for microwave radiometers.
        Proc. 25th IGARSS, 3404?3409.
      |||,
    },
    {
      citation: |||
        S. Seto, T. Kubota, N. Takahashi, T. Iguchi, T. Oki, 2008: Advanced
        rain/no-rain classification methods for microwave radiometer observations
        over land, J. Appl. Meteo. Clim., 47, 11, 3016-3029.
      |||,
    },
    {
      citation: |||
        T. Kozu, T. Iguchi, T. Kubota, N. Yoshida, S. Seto, J. Kwiatkowski,
        and Y. N. Takayabu, 2009: Feasibility of Raindrop Size Distribution
        Parameter Estimation with TRMM Precipitation Radar. J. Meteor.
        Soc. Japan, 87A, 53-66.
      |||,
    },
    {
      citation: |||
        T. Kubota, S. Shige, K. Aonashi, K. Okamoto, 2009: Development
        of nonuniform beamfilling correction method in rainfall retrievals
        for passive microwave radiometers over ocean using TRMM observations.
        J. Meteor. Soc. Japan, 87A, 153-164.
      |||,
    },
    {
      citation: |||
        S. Kida, S. Shige, T. Kubota, K. Aonashi, and K. Okamoto, 2009:
        Improvement of rain/no-rain classification methods for microwave
        radiometer observations over ocean using the 37-GHz emission signature.
        J. Meteor. Soc. Japan, 87A, 165-181.
      |||,
    },
    {
      citation: |||
        S. Shige, T. Watanabe, H. Sasaki,T. Kubota, S. Kida, and K. Okamoto,
        2008: Validation of western and eastern Pacific rainfall estimates
        from the TRMM PR using a radiative transfer model, J. Geophys.
        Res., doi:10.1029/2007JD009002
      |||,
      doi: '10.1029/2007JD009002',
    },
    {
      citation: |||
        S. Seto, T. Kubota, T. Iguchi, N. Takahashi, T. Oki, 2009: An
        evaluation of over-land rain rate estimates by the GSMaP and GPROF
        algorithms;The role of lower-frequency channels. J. Meteor. Soc.
        Japan, 87A, 183-202.
      |||,
    },
    {
      citation: |||
        T. Kubota, T. Ushio, S. Shige, S. Kida, M. Kachi, and K. Okamoto,
        2009: Verification of high resolution satellite-based rainfall
        estimates around Japan using gauge-calibrated ground radar dataset.
        J. Meteor. Soc. Japan, 87A, 203-222.
      |||,
    },
    {
      citation: |||
        S. Kida, T. Kubota, M. Kachi, S. Shige, and R. Oki, 2012: Development
        of precipitation retrieval algorithm over land for a satellite-borne
        microwave sounder. Proc. of IGARSS 2012, 342-345.
      |||,
    },
    {
      citation: |||
        A. Taniguchi, S. Shige, M. K. Yamamoto, T. Mega, S. Kida, T. Kubota,
        M. Kachi, T. Ushio, and K. Aonashi, 2013: Improvement of high-resolution
        satellite rainfall product for Typhoon Morakot (2009) over Taiwan.
        J. Hydrometeor., 14, 1859-1871.
      |||,
    },
    {
      citation: |||
        T. Kubota, S. Shige, M. Kachi, and K. Aonashi. 2011: Development
        of SSMIS rain retrieval algorithm in the GSMaP project. Proc 28th
        ISTS, 2011-n-46.
      |||,
    },
    {
      citation: |||
        T. Ushio, T. Tashima, T. Kubota, and M. Kachi, 2013: Gauge Adjusted
        Global Satellite Mapping of Precipitation (GSMaP_Gauge), Proc.
        29th ISTS, 2013-n-48.
      |||,
    },
    {
      citation: |||
        S. Shige, M.K. Yamamoto, and A. Taniguchi, 2014. Improvement of
        TMI rain retrieval over the Indian Subcontinent. Geophys. Monogr.
        Ser. (in print).
      |||,
    },
    {
      citation: |||
        M.K. Yamamoto, and S. Shige, 2014: Implementation of an orographic/nonorographic
        rainfall classification scheme in the GSMaP algorithm for microwave
        radiometers. Atmos. Res. (in print).
      |||,
    },
  ],
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
