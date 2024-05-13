local id = 'GOOGLE/GLOBAL_CCDC/V1';
local subdir = 'GOOGLE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO(gorelick): remove gee:user_uploaded if the tiles are in a public
  // location. For now the asset doesn't exist.
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Google Global Landsat-based CCDC Segments (1999-2019)',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This collection contains precomputed results from running the
    Continuous Change Detection and Classification (CCDC) algorithm on
    20 years of Landsat surface reflectance data. CCDC is a break-point
    finding algorithm that uses harmonic fitting with a dynamic RMSE
    threshold to detect breakpoints in time-series data.

    The dataset was created from the Landsat 5, 7, and 8 Collection-1, Tier-1,
    surface reflectance time series, using all daytime images between 1999-01-01
    and 2019-12-31. Each image was preprocessed to mask pixels identified as
    cloud, shadow, or snow (according to the 'pixel_qa' band), saturated pixels,
    and pixels with an atmospheric opacity > 300 (as identified by the
    'sr_atmos_opacity' and 'sr_aerosol' bands). Pixels repeated in
    north/south scene overlap were deduplicated. The results were
    output in 2-degree tiles for all landmasses between -60&deg; and +85&deg; latitude.
    The images are suitable to simply mosaic() into one global image.

    The CCDC algorithm was run with the default algorithm parameters except for
    the dateFormat:

    * tmaskBands: ['green', 'swir']
    * minObservations: 6
    * chiSquareProbability: 0.99
    * minNumOfYearsScaler: 1.33
    * dateFormat: 1 (fractional year)
    * lambda: 20
    * maxIterations: 25000

    Each pixel in the output is encoded using variable length arrays.  The outer
    length of each array (axis 0) corresponds to the number of breakpoints
    found at that location. The coefs bands contain 2-D arrays, where each inner
    array contains the scaling factors for the 8 terms in the linear harmonic
    model, in the order: [offset, t, cos(&omega;t), sin(&omega;t), cos(2&omega;t),
    sin(2&omega;t), cos(3&omega;t), sin(3&omega;t)], where &omega; = 2&Pi;.  The
    models are scale to produce refelectance units (0.0 - 1.0) for the optical
    bands and degrees (K) / 100.0 for the thermal band.

    Note that since the output bands are arrays and can only be downsampled
    using a SAMPLE pyramiding policy. At lower zoom levels, the
    results are usually no longer representative of the full-resolution data,
    and, for instance, tile boundaries can be seen due to the downsampled masks.
    It's therefore not recommended to use this dataset at resolutions less than
    240m/pixel.

    There are no current plans to add post-2019 assets to this dataset.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'change_detection',
    'google',
    'landcover',
    'landsat_derived',
    'landuse',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    -180, -60, 180, 72, '1999-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30,
    ],
    'eo:bands': [
      {
        name: 'tStart',
        description: '1-D Array containing the date of the start of each segment (fractional year).',
      },
      {
        name: 'tEnd',
        description: '1-D Array containing the date of the end of each segment (fractional year).',
      },
      {
        name: 'tBreak',
        description: '1-D Array containing the date of the detected breakpoint of each segment (fractional year).',
      },
      {
        name: 'numObs',
        description: '1-D Array containing the number of observations found in each segment.',
      },
      {
        name: 'changeProb',
        description: 'A pseudo-probability of the detected breakpoint being real.',
      },
      {
        name: 'BLUE_coefs',
        description: '2-D array containing harmonic model coefficients for the blue band, for each segment.'
      },
      {
        name: 'GREEN_coefs',
        description: '2-D array containing harmonic model coefficients for the green band, for each segment.'
      },
      {
        name: 'RED_coefs',
        description: '2-D array containing harmonic model coefficients for the red band, for each segment.'
      },
      {
        name: 'NIR_coefs',
        description: '2-D array containing harmonic model coefficients for the near-infrared band, for each segment.'
      },
      {
        name: 'SWIR1_coefs',
        description: '2-D array containing harmonic model coefficients for the shortwave-infrared (1.55&mu;m-1.75&mu;m) band, for each segment.'
      },
      {
        name: 'SWIR2_coefs',
        description: '2-D array containing harmonic model coefficients for the shortwave-infrared (2.09&mu;m-2.35&mu;m) band, for each segment.'
      },
      {
        name: 'TEMP_coefs',
        description: '2-D array containing harmonic model coefficients for the thermal band, for each segment.'
      },
      {
        name: 'BLUE_rmse',
        description: '1-D array containing the RMSE of the model for the blue band, for each segment.'
      },
      {
        name: 'GREEN_rmse',
        description: '1-D array containing the RMSE of the model for the green band, for each segment.'
      },
      {
        name: 'RED_rmse',
        description: '1-D array containing the RMSE of the model for the red band, for each segment.'
      },
      {
        name: 'NIR_rmse',
        description: '1-D array containing the RMSE of the model for the near-infrared band, for each segment.'
      },
      {
        name: 'SWIR1_rmse',
        description: '1-D array containing the RMSE of the model for the the shortwave-infrared (1.55&mu;m-1.75&mu;m) band, for each segment.'
      },
      {
        name: 'SWIR2_rmse',
        description: '1-D array containing the RMSE of the model for the shortwave-infrared (2.09&mu;m-2.35&mu;m) band, for each segment.'
      },
      {
        name: 'TEMP_rmse',
        description: '1-D array containing the RMSE of the model for the thermal band, for each segment.'
      },
      {
        name: 'BLUE_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the blue band, for each segment.'
      },
      {
        name: 'GREEN_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the green band, for each segment.'
      },
      {
        name: 'RED_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the red band, for each segment.'
      },
      {
        name: 'NIR_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the near-infrared band, for each segment.'
      },
      {
        name: 'SWIR1_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the shortwave-infrared-1 (1.55&mu;m-1.75&mu;m) band, for each segment.'
      },
      {
        name: 'SWIR2_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the shortwave-infrared-2 (2.09&mu;m-2.35&mu;m) band, for each segment.'
      },
      {
        name: 'TEMP_magnitude',
        description: '1-D array containing the magnitude of the detected breakpoint for the thermal band, for each segment.'
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Global CCDC',
        lookat: {
          lat: 36,
          lon: -116,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1,
            ],
            bands: [
              'RED_coefs',
              'GREEN_coefs',
              'BLUE_coefs'
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
