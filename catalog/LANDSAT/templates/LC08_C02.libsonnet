local common_bands = import 'common_bands.libsonnet';

{
  summaries: {
    'gee:schema': [
      {
        name: 'CLOUD_COVER',
        description: 'Percentage cloud cover (0-100), -1 = not calculated.',
        type: 'DOUBLE',
      },
      {
        name: 'CLOUD_COVER_LAND',
        description: 'Percentage cloud cover over land (0-100), -1 = not calculated.',
        type: 'DOUBLE',
      },
      {
        name: 'COLLECTION_CATEGORY',
        description: 'Tier of scene. (T1 or T2)',
        type: 'STRING',
      },
      {
        name: 'COLLECTION_NUMBER',
        description: 'Number of collection.',
        type: 'DOUBLE',
      },
      {
        name: 'DATA_SOURCE_ELEVATION',
        description: |||
  Indicates the source of the DEM used in the
  correction process. Possible values: "GLS2000", "RAMP", "GTOPO30".'
|||,
        type: 'STRING',
      },
      {
        name: 'DATA_SOURCE_TIRS_STRAY_LIGHT_CORRECTION',
        description: |||
  The correction source used in creating the Landsat 8 TIRS stray light
  correction image. This field is not included for Landsat 9.
|||,
        type: 'STRING',
      },
      {
        name: 'DATE_ACQUIRED',
        description: 'Image acquisition date. "YYYY-MM-DD"',
        type: 'STRING',
      },
      {
        name: 'DATE_PRODUCT_GENERATED',
        description: 'Product generation epoch.',
        type: 'INT',
      },
      {
        name: 'DATUM',
        description: 'Datum used in image creation.',
        type: 'STRING',
      },
      {
        name: 'EARTH_SUN_DISTANCE',
        description: 'Earth sun distance in astronomical units (AU).',
        type: 'DOUBLE',
      },
      {
        name: 'ELLIPSOID',
        description: 'Ellipsoid used in image creation.',
        type: 'STRING',
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL',
        description: |||
          Combined Root Mean Square Error (RMSE) of the geometric residuals
          (metres) in both across-track and along-track directions
          measured on the GCPs used in geometric precision correction.
          Not present in L1G products.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_X',
        description: |||
          RMSE of the X direction geometric residuals (in metres) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_Y',
        description: |||
          RMSE of the Y direction geometric residuals (in metres) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GRID_CELL_SIZE_PANCHROMATIC',
        description: 'Grid cell size used in creating the image for the panchromatic band.',
        type: 'DOUBLE',
      },
      {
        name: 'GRID_CELL_SIZE_REFLECTIVE',
        description: 'Grid cell size used in creating the image for the reflective band.',
        type: 'DOUBLE',
      },
      {
        name: 'GRID_CELL_SIZE_THERMAL',
        description: 'Grid cell size used in creating the image for the thermal band.',
        type: 'DOUBLE',
      },
      {
        name: 'GROUND_CONTROL_POINTS_MODEL',
        description: |||
          The number of ground control points used. Not used in L1GT products.
          Values: 0 - 999 (0 is used for L1T products that have used
          Multi-scene refinement).
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GROUND_CONTROL_POINTS_VERSION',
        description: |||
          The number of ground control points used in the verification of
          the terrain corrected product. Values: -1 to 1615 (-1 = not available)
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'IMAGE_QUALITY_OLI',
        description: |||
          The composite image quality for the OLI bands. Values: 9 = Best. 1 = Worst. 0 = Image quality not calculated. This parameter is only present if OLI bands are present in the product.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'IMAGE_QUALITY_TIRS',
        description: |||
          The composite image quality for the TIRS bands. Values: 9 = Best. 1 = Worst. 0 = Image quality not calculated. This parameter is only present if OLI bands are present in the product.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'K1_CONSTANT_BAND_10',
        description: 'Calibration K1 constant for Band 10 radiance to temperature conversion.',
        type: 'DOUBLE',
      },
      {
        name: 'K1_CONSTANT_BAND_11',
        description: 'Calibration K1 constant for Band 11 radiance to temperature conversion.',
        type: 'DOUBLE',
      },
      {
        name: 'K2_CONSTANT_BAND_10',
        description: 'Calibration K2 constant for Band 10 radiance to temperature conversion.',
        type: 'DOUBLE',
      },
      {
        name: 'K2_CONSTANT_BAND_11',
        description: 'Calibration K2 constant for Band 11 radiance to temperature conversion.',
        type: 'DOUBLE',
      },
      {
        name: 'LANDSAT_PRODUCT_ID',
        description: |||
          The naming convention of each Landsat Collection N Level-1 image based
          on acquisition parameters and processing parameters.

          Format: LXSS_LLLL_PPPRRR_YYYYMMDD_yyyymmdd_CC_TX

          *  L = Landsat
          *  X = Sensor (O = Operational Land Imager,
          T = Thermal Infrared Sensor, C = Combined OLI/TIRS)
          *  SS = Satellite (08 = Landsat 8)
          *  LLLL = Processing Correction Level (L1TP = precision and terrain,
          L1GT = systematic terrain, L1GS = systematic)
          *  PPP = WRS Path
          *  RRR = WRS Row
          *  YYYYMMDD = Acquisition Date expressed in Year, Month, Day
          *  yyyymmdd = Processing Date expressed in Year, Month, Day
          *  CC = Collection Number (02)
          *  TX = Collection Category (RT = Real Time, T1 = Tier 1, T2 = Tier 2)
        |||,
        type: 'STRING',
      },
      {
        name: 'LANDSAT_SCENE_ID',
        description: |||
          The Pre-Collection naming convention of each image is based on acquisition
          parameters. This was the naming convention used prior to Collection 1.

          Format: LXSPPPRRRYYYYDDDGSIVV

          *  L = Landsat
          *  X = Sensor (O = Operational Land Imager, T = Thermal Infrared Sensor, C = Combined OLI/TIRS)
          *  S = Satellite (08 = Landsat 8)
          *  PPP = WRS Path
          *  RRR = WRS Row
          *  YYYY = Year of Acquisition
          *  DDD = Julian Day of Acquisition
          *  GSI = Ground Station Identifier
          *  VV = Version
        |||,
        type: 'STRING',
      },
      {
        name: 'MAP_PROJECTION',
        description: 'Projection used to represent the 3-dimensional surface of the earth for the Level-1 product.',
        type: 'STRING',
      },
      {
        name: 'NADIR_OFFNADIR',
        description: 'Nadir or Off-Nadir condition of the scene.',
        type: 'STRING',
      },
      {
        name: 'ORIENTATION',
        description: |||
          Orientation used in creating the image. Values: NOMINAL = Nominal Path, NORTH_UP = North Up, TRUE_NORTH = True North, USER = User
        |||,
        type: 'STRING',
      },
      {
        name: 'PANCHROMATIC_LINES',
        description: 'Number of product lines for the panchromatic band.',
        type: 'DOUBLE',
      },
      {
        name: 'PANCHROMATIC_SAMPLES',
        description: 'Number of product samples for the panchromatic bands.',
        type: 'DOUBLE',
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description: 'Name and version of the processing software used to generate the L1 product.',
        type: 'STRING',
      },
      {
        name: 'RADIANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 1.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_10',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 10.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_11',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 11.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 2.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 3.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 4.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_5',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 5.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_6',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 6.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_7',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 7.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_8',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 8.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_ADD_BAND_9',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 9.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_1',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 1 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_10',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 10 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_11',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 11 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_2',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 2 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_3',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 3 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_4',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 4 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_5',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 5 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_6',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 6 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_7',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 7 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_8',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 8 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'RADIANCE_MULT_BAND_9',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 9 DN to radiance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated Band 1 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated Band 2 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated Band 3 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated Band 4 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_5',
        description: 'Additive rescaling factor used to convert calibrated Band 5 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_7',
        description: 'Multiplicative factor used to convert calibrated Band 7 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_8',
        description: 'Multiplicative factor used to convert calibrated Band 8 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_9',
        description: 'Minimum achievable spectral reflectance value for Band 8.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_1',
        description: 'Multiplicative factor used to convert calibrated Band 1 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_2',
        description: 'Multiplicative factor used to convert calibrated Band 2 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_3',
        description: 'Multiplicative factor used to convert calibrated Band 3 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_4',
        description: 'Multiplicative factor used to convert calibrated Band 4 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_5',
        description: 'Multiplicative factor used to convert calibrated Band 5 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_6',
        description: 'Multiplicative factor used to convert calibrated Band 6 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_7',
        description: 'Multiplicative factor used to convert calibrated Band 7 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_8',
        description: 'Multiplicative factor used to convert calibrated Band 8 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_MULT_BAND_9',
        description: 'Multiplicative factor used to convert calibrated Band 9 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTIVE_LINES',
        description: 'Number of product lines for the reflective bands.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTIVE_SAMPLES',
        description: 'Number of product samples for the reflective bands.',
        type: 'DOUBLE',
      },
      {
        name: 'REQUEST_ID',
        description: 'Request id, nnnyymmdd0000_0000\n\n*  nnn = node number\n*  yy = year\n*  mm = month\n*  dd = day',
        type: 'STRING',
      },
      {
        name: 'RESAMPLING_OPTION',
        description: 'Resampling option used in creating the image.',
        type: 'STRING',
      },
      {
        name: 'ROLL_ANGLE',
        description: 'The amount of spacecraft roll angle at the scene center.',
        type: 'DOUBLE',
      },
      {
        name: 'SATURATION_BAND_1',
        description: "Flag indicating saturated pixels for band 1 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_10',
        description: "Flag indicating saturated pixels for band 10 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_11',
        description: "Flag indicating saturated pixels for band 11 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_2',
        description: "Flag indicating saturated pixels for band 2 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_3',
        description: "Flag indicating saturated pixels for band 3 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_4',
        description: "Flag indicating saturated pixels for band 4 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_5',
        description: "Flag indicating saturated pixels for band 5 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_6',
        description: "Flag indicating saturated pixels for band 6 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_7',
        description: "Flag indicating saturated pixels for band 7 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_8',
        description: "Flag indicating saturated pixels for band 8 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SATURATION_BAND_9',
        description: "Flag indicating saturated pixels for band 9 ('Y'/'N')",
        type: 'STRING',
      },
      {
        name: 'SCENE_CENTER_TIME',
        description: |||
          Scene center time of acquired image. HH:MM:SS.SSSSSSSZ

          *  HH = Hour (00-23)
          *  MM = Minutes
          *  SS.SSSSSSS = Fractional seconds
          *  Z = "Zulu" time (same as GMT)
        |||,
        type: 'STRING',
      },
      {
        name: 'SENSOR_ID',
        description: 'Sensor used to capture data.',
        type: 'STRING',
      },
      {
        name: 'SPACECRAFT_ID',
        description: 'Spacecraft identification.',
        type: 'STRING',
      },
      {
        name: 'STATION_ID',
        description: 'Ground Station/Organisation that received the data.',
        type: 'STRING',
      },
      {
        name: 'SUN_AZIMUTH',
        description: 'Sun azimuth angle in degrees for the image center location at the image centre acquisition time.',
        type: 'DOUBLE',
      },
      {
        name: 'SUN_ELEVATION',
        description: 'Sun elevation angle in degrees for the image center location at the image centre acquisition time.',
        type: 'DOUBLE',
      },
      {
        name: 'TARGET_WRS_PATH',
        description: 'Nearest WRS-2 path to the line-of-sight scene center of the image.',
        type: 'DOUBLE',
      },
      {
        name: 'TARGET_WRS_ROW',
        description: |||
          Nearest WRS-2 row to the line-of-sight scene center of the image. Rows 880-889 and 990-999 are reserved for the polar regions where it is undefined in the WRS-2.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'THERMAL_LINES',
        description: 'Number of product lines for the thermal band.',
        type: 'DOUBLE',
      },
      {
        name: 'THERMAL_SAMPLES',
        description: 'Number of product samples for the thermal band.',
        type: 'DOUBLE',
      },
      {
        name: 'TIRS_SSM_MODEL',
        description: |||
          Due to an anomalous condition on the Thermal Infrared
          Sensor (TIRS) Scene Select Mirror (SSM) encoder electronics,
          this field has been added to indicate which model was used to process the data.
          (Actual, Preliminary, Final)
        |||,
        type: 'STRING',
      },
      {
        name: 'TIRS_SSM_POSITION_STATUS',
        description: 'TIRS SSM position status.',
        type: 'STRING',
      },
      {
        name: 'TIRS_STRAY_LIGHT_CORRECTION_SOURCE',
        description: 'TIRS stray light correction source.',
        type: 'STRING',
      },
      {
        name: 'TRUNCATION_OLI',
        description: 'Region of OLCI truncated.',
        type: 'STRING',
      },
      {
        name: 'UTM_ZONE',
        description: 'UTM zone number used in product map projection.',
        type: 'DOUBLE',
      },
      {
        name: 'WRS_PATH',
        description: 'The WRS orbital path number (001 - 251).',
        type: 'DOUBLE',
      },
      {
        name: 'WRS_ROW',
        description: 'Landsat satellite WRS row (001-248).',
        type: 'DOUBLE',
      },
      {
        name: 'WRS_TYPE',
        description: |||
  World Reference System (WRS) type used for the collection of this scene.
|||,
        type: 'DOUBLE',
      },
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Coastal aerosol',
        center_wavelength: 0.44,
        gsd: 30.0,
        'gee:wavelength': '0.43 - 0.45 &mu;m',
      },
      {
        name: 'B2',
        description: 'Blue',
        center_wavelength: 0.48,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.51 &mu;m',
      },
      {
        name: 'B3',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.53 - 0.59 &mu;m',
      },
      {
        name: 'B4',
        description: 'Red',
        center_wavelength: 0.655,
        gsd: 30.0,
        'gee:wavelength': '0.64 - 0.67 &mu;m',
      },
      {
        name: 'B5',
        description: 'Near infrared',
        center_wavelength: 0.865,
        gsd: 30.0,
        'gee:wavelength': '0.85 - 0.88 &mu;m',
      },
      {
        name: 'B6',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.61,
        gsd: 30.0,
        'gee:wavelength': '1.57 - 1.65 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.2,
        gsd: 30.0,
        'gee:wavelength': '2.11 - 2.29 &mu;m',
      },
      {
        name: 'B8',
        description: 'Band 8 Panchromatic',
        center_wavelength: 0.71,
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.90 &mu;m',
      },
      {
        name: 'B9',
        description: 'Cirrus',
        center_wavelength: 1.37,
        gsd: 15.0,
        'gee:wavelength': '1.36 - 1.38 &mu;m',
      },
      {
        name: 'B10',
        description: 'Thermal infrared 1, resampled from 100m to 30m',
        center_wavelength: 10.895,
        gsd: 30.0,
        'gee:wavelength': '10.60 - 11.19 &mu;m',
      },
      {
        name: 'B11',
        description: 'Thermal infrared 2, resampled from 100m to 30m',
        center_wavelength: 12.005,
        gsd: 30.0,
        'gee:wavelength': '11.50 - 12.51 &mu;m',
      },
    ] + common_bands.common_bands_oli_tirs,
    'gee:visualizations': [
      {
        display_name: 'True Color (432)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'B4',
              'B3',
              'B2',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (543)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'B5',
              'B4',
              'B3',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (753)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'B7',
              'B5',
              'B3',
            ],
          },
        },
      },
    ],
  }
}
