local id = 'TRMM/3B43V7';
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
  title: 'TRMM 3B43: Monthly Precipitation Estimates',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    **This collection is no longer being updated. See
    [IMERG monthly](https://developers.google.com/earth-engine/datasets/catalog/NASA_GPM_L3_IMERG_MONTHLY_V06)**

    This dataset algorithmically merges microwave data from multiple satellites,
    including SSMI, SSMIS, MHS, AMSU-B and AMSR-E, each inter-calibrated to the
    TRMM Combined Instrument.

    Algorithm 3B43 is executed once per calendar month to produce the single,
    best-estimate precipitation rate and RMS precipitation-error estimate field
    (3B43) by combining the 3-hourly merged high-quality/IR estimates (3B42)
    with the monthly accumulated Global Precipitation Climatology Centre (GPCC)
    rain gauge analysis.

    All of the global precipitation datasets have some calibrating data source,
    which is necessary to control bias differences between contributing
    satellites.  The multi-satellite data are averaged to the monthly scale and
    combined with the Global Precipitation Climatology Centre's (GPCC) monthly
    surface precipitation gauge analysis. In each case the multi-satellite data
    are adjusted to the large-area mean of the gauge analysis, where available
    (mostly over land), and then combined with the gauge analysis using a
    simple inverse estimated-random-error variance weighting.  Regions with poor
    gauge coverage, like central Africa and the oceans, have a higher weighting
    on the satellite input.

    See the [algorithm description](https://trmm.gsfc.nasa.gov/3b43.html)
    and the [file specification](https://pps.gsfc.nasa.gov/Documents/filespec.TRMM.V7.pdf)
    for details.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://disc2.gesdisc.eosdis.nasa.gov/data/TRMM_L3/TRMM_3B43.7/',
    },
  ],
  keywords: [
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
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/TRMM/TMPA/MONTH/7'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -50.0, 180.0, 50.0,
                    '1998-01-01T00:00:00Z', '2019-12-01T00:00:00Z'),
  summaries: {
    gsd: [
      27830.0,
    ],
    platform: [
      'TRMM',
    ],
    instruments: [
      'CERES',
      'LSI',
      'PR',
      'TMI',
      'VIRS',
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
        name: 'gaugeRelativeWeighting',
        description: 'Relative weighting of the rain gauges used in calibration',
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 6.746,
          lon: 46.529,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.1,
            ],
            max: [
              1.2,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'precipitation',
            ],
          },
        },
      },
    ],
    precipitation: {
      minimum: 0.0,
      maximum: 6.73,
      'gee:estimated_range': true,
    },
    relativeError: {
      minimum: 0.001,
      maximum: 16.36,
      'gee:estimated_range': true,
    },
    gaugeRelativeWeighting: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
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
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
