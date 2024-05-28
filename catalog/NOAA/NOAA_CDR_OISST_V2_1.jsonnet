local id = 'NOAA/CDR/OISST/V2_1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/CDR_OISST_versions.libsonnet';

local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NOAA CDR OISST v02r01: Optimum Interpolation Sea Surface Temperature',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA 1/4 degree daily Optimum Interpolation Sea Surface Temperature
    (OISST) provides complete ocean temperature fields constructed by combining
    bias-adjusted observations from different platforms (satellite, ships,
    buoys) on a regular global grid, with gaps filled in by interpolation.
    Satellite data from the Advanced Very High Resolution Radiometer (AVHRR)
    provides the main input which permits the high temporal-spatial coverage
    beginning in late 1981 to the present.

    The OISST dataset has a single day's data processed twice. First a near
    real-time preliminary version is released with a lag of 1 day, and a final
    version with a lag of 14 days. The final version uses extra days for
    smoothing, and zonal bias correction in addition to replacing the
    preliminary version.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5SQ8XB5',
    },
  ] + version_config.version_links,
  keywords: [
    'avhrr',
    'cdr',
    'daily',
    'ice',
    'noaa',
    'ocean',
    'oisst',
    'real_time',
    'sst',
    'temperature',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/optimum-interpolation-sst'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1981-09-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'provisional' or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'sst',
        description: 'Daily sea surface temperature',
        'gee:units': units.celsius,
        'gee:scale': 0.01,
      },
      {
        name: 'anom',
        description: 'Temperature anomaly; the daily OISST minus a 30-year climatological mean.',
        'gee:units': units.celsius,
        'gee:scale': 0.01,
      },
      {
        name: 'ice',
        description: 'Seven-day median of daily sea ice concentrations.',
        'gee:units': units.percent,
        'gee:scale': 0.01,
      },
      {
        name: 'err',
        description: 'Estimated error; standard deviation of analyzed sea surface temperature.',
        'gee:units': units.celsius,
        'gee:scale': 0.01,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sea Surface Temperature',
        lookat: {
          lat: -20.39,
          lon: 20.3,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -180.0,
            ],
            max: [
              3000.0,
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
              'sst',
            ],
          },
        },
      },
    ],
    sst: {
      minimum: -180.0,
      maximum: 3764.0,
      'gee:estimated_range': true,
    },
    anom: {
      minimum: -1887.0,
      maximum: 1902.0,
      'gee:estimated_range': true,
    },
    ice: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    err: {
      minimum: 11.0,
      maximum: 171.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5SQ8XB5',
  'sci:citation': |||
    Richard W. Reynolds, Viva F. Banzon, and NOAA CDR Program (2008): NOAA
    Optimum Interpolation 1/4 Degree Daily Sea Surface Temperature (OISST)
    Analysis, Version 2. [indicate subset used]. NOAA National Centers for
    Environmental Information. [doi:10.7289/V5SQ8XB5](https://doi.org/10.7289/V5SQ8XB5)
    [access date].
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
