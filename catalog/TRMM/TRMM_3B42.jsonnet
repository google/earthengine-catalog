local id = 'TRMM/3B42';
local subdir = 'TRMM';

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
  ],
  id: id,
  title: 'TRMM 3B42: 3-Hourly Precipitation Estimates',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Tropical Rainfall Measuring Mission (TRMM) is a
    joint mission between NASA and the Japan Aerospace Exploration
    Agency (JAXA) designed to monitor and study tropical rainfall.
    The 34B2 product contains a gridded, TRMM-adjusted, merged infrared
    precipitation (mm/hr) and RMS precipitation-error estimate, with
    a 3-hour temporal resolution and a 0.25 degree spatial resolution.

    See the [algorithm description](https://trmm.gsfc.nasa.gov/3b42.html)
    and the [file specification](https://storm.pps.eosdis.nasa.gov/storm/data/docs/filespec.TRMM.V7.3B42.pdf)
    for details.

    Documentation:

    * [PI Documentation](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/3B42_3B43_doc_V7.pdf)

    * [File Specification for TRMM Products](https://pps.gsfc.nasa.gov/Documents/filespec.TRMM.V7.pdf)

    * [Comparison between TRMM versions 6 and 7](https://pps.gsfc.nasa.gov/Documents/formatChangesV7.pdf)

    * [Readme](https://disc2.gesdisc.eosdis.nasa.gov/data/TRMM_L3/TRMM_3B42/doc/README.TRMM_V7.pdf)

    * [Details of the TMPA algorithm used in this product](https://pmm.nasa.gov/sites/default/files/imce/3B42_3B43_TMPA_restart.pdf)

    * [TRMM Data Gaps](https://web.archive.org/web/20200701000000*/ftp://gpmweb2.pps.eosdis.nasa.gov/tsdis/AB/docs/anomalous.html)

    * [Transition from TMPA to IMERG](https://docserver.gesdisc.eosdis.nasa.gov/public/project/GPM/TMPA-to-IMERG_transition.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    '3_hourly',
    'climate',
    'geophysical',
    'jaxa',
    'nasa',
    'precipitation',
    'rainfall',
    'trmm',
    'weather',
  ],
  providers: [
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/TRMM/TMPA/3H/7'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1281704371-GES_DISC',
  ],
  extent: ee.extent(-180.0, -50.0, 180.0, 50.0,
                    '1998-01-01T00:00:00Z', '2019-12-31T21:00:00Z'),
  summaries: {
    gsd: [
      27830.0,
    ],
    platform: [
      'TRMM',
    ],
    instruments: [
      'TMI',
    ],
    'eo:bands': [
      {
        name: 'precipitation',
        description: 'Merged microwave/IR precipitation estimate',
        'gee:units': 'mm/hr',
      },
      {
        name: 'relativeError',
        description: 'Merged microwave/IR precipitation random error estimate',
        'gee:units': 'mm/hr',
      },
      {
        name: 'satPrecipitationSource',
        description: 'Flag to show source of data',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Source',
              bit_count: 6,
              values: [
                {
                  description: 'No observation',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'AMSU',
                },
                {
                  value: 2,
                  description: 'TMI',
                },
                {
                  value: 3,
                  description: 'AMSR',
                },
                {
                  value: 4,
                  description: 'SSMI',
                },
                {
                  value: 5,
                  description: 'SSMI/S',
                },
                {
                  value: 6,
                  description: 'MHS',
                },
                {
                  value: 7,
                  description: 'TCI',
                },
                {
                  value: 30,
                  description: 'AMSU/MHS average',
                },
                {
                  value: 31,
                  description: 'Conical scanner average',
                },
                {
                  value: 50,
                  description: 'IR',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 6,
        },
      },
      {
        name: 'HQprecipitation',
        description: 'Pre-gauge-adjusted microwave precipitation estimate',
        'gee:units': 'mm/hr',
      },
      {
        name: 'IRprecipitation',
        description: 'Pre-gauge-adjusted infrared precipitation estimate',
        'gee:units': 'mm/hr',
      },
      {
        name: 'satObservationTime',
        description: |||
          Satellite observation time minus the time of the granule.
          In case of overlapping satellite observations, the two or more
          observation times are equal-weighting averaged.
        |||,
        'gee:units': units.minute,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 23.32,
          lon: -79.98,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              12.0,
            ],
            gamma: [
              5.0,
            ],
            bands: [
              'precipitation',
              'HQprecipitation',
              'IRprecipitation',
            ],
          },
        },
      },
    ],
    precipitation: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    relativeError: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    HQprecipitation: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    IRprecipitation: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    satObservationTime: {
      minimum: -90.0,
      maximum: 90.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Adler, R.F., G.J. Huffman, A. Chang, R. Ferraro, P. Xie, J. Janowiak,
    B. Rudolf, U. Schneider, S. Curtis, D. Bolvin, A. Gruber, J. Susskind,
    P. Arkin, E.J. Nelkin, 2003: The Version 2 Global Precipitation
    Climatology Project (GPCP) Monthly Precipitation Analysis (1979-Present).
    J. Hydrometeor., 4(6), 1147-1167.
  |||,
  'sci:publications': [
    {
      citation: |||
        Huffman, G.J., 1997: Estimates of Root-Mean-Square Random Error
        for Finite Samples of Estimated Precipitation, J. Appl. Meteor.,
        1191-1201.
      |||,
    },
    {
      citation: |||
        Huffman, G.J., 2012:  Algorithm Theoretical Basis Document (ATBD)
        Version 3.0 for the NASA Global Precipitation Measurement (GPM)
        Integrated Multi-satellitE Retrievals for GPM (I-MERG).  GPM Project,
        Greenbelt, MD, 29 pp.
      |||,
    },
    {
      citation: |||
        Huffman, G.J., R.F. Adler, P. Arkin, A. Chang, R. Ferraro, A.
        Gruber, J. Janowiak, A. McNab, B. Rudolph, and U. Schneider, 1997:
        The Global Precipitation Climatology Project (GPCP) Combined Precipitation
        Dataset, Bul. Amer. Meteor. Soc., 78, 5-20.
      |||,
    },
    {
      citation: |||
        Huffman, G.J., R.F. Adler, D.T. Bolvin, G. Gu, E.J. Nelkin, K.P.
        Bowman, Y. Hong, E.F. Stocker, D.B. Wolff, 2007: The TRMM Multi-satellite
        Precipitation Analysis: Quasi-Global, Multi-Year, Combined-Sensor
        Precipitation Estimates at Fine Scale. J. Hydrometeor., 8(1), 38-55.
      |||,
    },
    {
      citation: |||
        Huffman, G.J., R.F. Adler, M. Morrissey, D.T. Bolvin, S. Curtis,
        R. Joyce, B McGavock, J. Susskind, 2001: Global Precipitation at
        One-Degree Daily Resolution from Multi-Satellite Observations.  J.
        Hydrometeor., 2(1), 36-50.
      |||,
    },
    {
      citation: |||
        Huffman, G.J., R.F. Adler, B. Rudolph, U. Schneider, and P. Keehn,
        1995: Global Precipitation Estimates Based on a Technique for Combining
        Satellite-Based Estimates, Rain Gauge Analysis, and NWP Model Precipitation
        Information, J. Clim., 8, 1284-1295.
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
