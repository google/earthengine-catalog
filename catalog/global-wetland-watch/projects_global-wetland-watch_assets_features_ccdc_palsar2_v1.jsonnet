// Structured as a companion to GOOGLE/GLOBAL_CCDC/V1 (Landsat-based CCDC).
local id = 'projects/global-wetland-watch/assets/features/ccdc/palsar2/v1';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local gww = import 'gww.libsonnet';

local subdir = gww.subdir;
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local pol_bands(pol) = [
  {
    name: pol + '_coefs',
    description: '2-D array containing harmonic model coefficients for ' + pol + ' backscatter, for each segment.',
  },
  {
    name: pol + '_rmse',
    description: '1-D array containing the root mean square error (RMSE) of the model for ' + pol + ' backscatter, for each segment.',
  },
  {
    name: pol + '_magnitude',
    description: '1-D array containing the magnitude of the detected breakpoint for ' + pol + ' backscatter, for each segment.',
  },
];

{
  id: id,
  title: 'Global Wetland Watch ALOS-2 PALSAR-2 ScanSAR CCDC Segments (2015-2024) v' + version,
  version: version,
  description: |||
    This collection contains precomputed results from running the
    Continuous Change Detection and Classification (CCDC;
    [Zhu & Woodcock, 2014](https://doi.org/10.1016/j.rse.2014.01.011))
    algorithm on ALOS-2 PALSAR-2 (Advanced Land Observing Satellite 2, Phased
    Array type L-band Synthetic Aperture Radar 2) ScanSAR L-band radar
    backscatter (HH and HV polarizations: horizontal transmit, horizontal or
    vertical receive) from 2015 to early 2024. CCDC is a break-point finding
    algorithm that uses harmonic fitting with a dynamic root mean square error (RMSE) threshold to
    detect breakpoints in time-series data. It is a radar companion to the
    Landsat-based Google Global CCDC Segments dataset
    ([GOOGLE/GLOBAL_CCDC/V1](https://developers.google.com/earth-engine/datasets/catalog/GOOGLE_GLOBAL_CCDC_V1))
    already in the Earth Engine catalog, and follows the same band structure,
    so the same tools and code can be used with both. Because L-band radar penetrates vegetation canopies, the results
    are sensitive to flooding under vegetation, for example in swamp forests
    and flooded grasslands.

    The results are tiled by country and are suitable to simply mosaic() into
    one image. The models are fitted to gamma-nought backscatter in decibels
    (&gamma;0 = 10 log10(DN&sup2;) &minus; 83.0 dB, where DN is the digital number). No spatial speckle
    filtering is applied, because the temporal modelling already suppresses
    speckle while preserving spatial resolution.

    The CCDC algorithm was run with the following parameters, which are the
    same for all images:

    * minObservations: 3
    * chiSquareProbability: 0.95
    * minNumOfYearsScaler: 1
    * dateFormat: 1 (fractional year)
    * lambda: 0.3
    * maxIterations: 10000

    CCDC results depend on these parameters, and different settings suit
    different applications. Lower chiSquareProbability and minObservations
    values detect more and smaller breaks, while a higher lambda produces
    smoother models with fewer non-zero coefficients. Users who need a
    different balance between sensitivity to change and model stability can
    run CCDC with other parameters on the
    [PALSAR-2 ScanSAR collection](https://developers.google.com/earth-engine/datasets/catalog/JAXA_ALOS_PALSAR-2_Level2_2_ScanSAR)
    in Earth Engine.

    Each pixel in the output is encoded using variable length arrays. The outer
    length of each array (axis 0) corresponds to the number of segments found
    at that location. The coefs bands contain 2-D arrays, where each inner
    array contains the scaling factors for the 8 terms in the linear harmonic
    model, in the order: [offset, t, cos(&omega;t), sin(&omega;t),
    cos(2&omega;t), sin(2&omega;t), cos(3&omega;t), sin(3&omega;t)], where
    &omega; = 2&pi;.

    Note that since the output bands are arrays, they can only be downsampled
    using a SAMPLE pyramiding policy. At lower zoom levels, the results are
    usually no longer representative of the full-resolution data, and tile
    boundaries can be seen.

    **Possible Uses:**

    * **Classification features:** Using harmonic coefficients, RMSE and
      magnitudes as inputs to wetland or land cover classifiers.
    * **Change detection:** Using `tBreak` and `changeProb` to identify
      abrupt changes such as deforestation or wetland drainage.
    * **Synthetic images:** Predicting expected backscatter for any date
      from the fitted coefficients.

    **Limitations:**

    * **Coverage:** 79 tropical and subtropical countries in Africa, South
      and Southeast Asia, and Central and South America. Coverage is limited
      by the availability of PALSAR-2 ScanSAR observations; regions with too
      few observations for reliable model fitting are not included.
    * **Observation density:** Segments with few observations (`numObs`)
      give less reliable fits.
    * **Period:** Tiles were processed in sequence, so the end of the
      observation period differs slightly between tiles. There are no current
      plans to extend the period.
  |||,
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'alos2',
    'change_detection',
    'jaxa',
    'palsar2',
    'sar',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  // Collection-level input period, derived from the tStart/tEnd bands of
  // sampled tiles (earliest 2015.01, latest 2024.24). Tiles were processed in
  // sequence, so each image's own period (system:time_start/end) ends
  // slightly differently.
  extent: ee.extent(-93.0, -36.0, 160.0, 34.0,
                    '2015-01-01T00:00:00Z', '2024-04-01T00:00:00Z'),
  summaries: {
    gsd: [25.0],
    platform: ['ALOS-2'],
    instruments: ['PALSAR-2'],
    'eo:bands': [
      {
        name: 'tStart',
        description: '1-D array containing the date of the start of each segment (fractional year).',
      },
      {
        name: 'tEnd',
        description: '1-D array containing the date of the end of each segment (fractional year).',
      },
      {
        name: 'tBreak',
        description: '1-D array containing the date of the detected breakpoint of each segment (fractional year).',
      },
      {
        name: 'numObs',
        description: '1-D array containing the number of observations found in each segment.',
      },
      {
        name: 'changeProb',
        description: 'A pseudo-probability of the detected breakpoint being real.',
      },
    ] + pol_bands('HV') + pol_bands('HH'),
    'gee:visualizations': [
      {
        display_name: 'HV model root mean square error',
        lookat: {lon: 30.5, lat: 7.5, zoom: 9},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [3],
            bands: ['HV_rmse'],
          },
        },
      },
    ],
    'gee:schema': [
      {name: 'sensor', description: 'Input sensor (scansar)', type: ee_const.var_type.string},
      {name: 'dateFormat', description: 'CCDC date format (1 = fractional year)', type: ee_const.var_type.int},
      {name: 'chiSquare', description: 'CCDC chiSquareProbability', type: ee_const.var_type.double},
      {name: 'lambda', description: 'CCDC lambda (regularization strength of the harmonic model fit)', type: ee_const.var_type.double},
      {name: 'minObs', description: 'CCDC minObservations', type: ee_const.var_type.int},
      {name: 'minYears', description: 'CCDC minNumOfYearsScaler', type: ee_const.var_type.double},
      {name: 'maxIter', description: 'CCDC maxIterations', type: ee_const.var_type.int},
    ],
  },
  'sci:citation': gww.citation,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "Global Wetland Watch (DHI, UNEP-DHI, UNEP), 2026".

    The original ALOS-2 PALSAR-2 ScanSAR data for this higher-level
    value-added product were provided by the Japan Aerospace Exploration
    Agency (JAXA). Use of the original data is subject to the JAXA
    [G-Portal Terms of Use](https://gportal.jaxa.jp/gpr/index/eula?lang=en)
    (Section 5, Conditions for Using Data Provided by G-Portal).
  |||,
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
