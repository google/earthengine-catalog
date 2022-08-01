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
        name: 'CORRECTION_GAIN_BAND_4',
        description: 'Internal calibration gain method for band 4.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_5',
        description: 'Internal calibration gain method for band 5.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_6',
        description: 'Internal calibration gain method for band 6.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_7',
        description: 'Internal calibration gain method for band 7.',
        type: 'STRING',
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
        name: 'DATA_TYPE_L0RP',
        description: 'Data type identifier string used to create the L0RP product.',
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
        name: 'EPHEMERIS_TYPE',
        description: 'Ephemeris data type used to perform geometric correction. (Definitive or Predictive)',
        type: 'STRING',
      },
      {
        name: 'GAIN_BAND_4',
        description: 'Gain state for Band 4. (L = Low gain, H = High)',
        type: 'STRING',
      },
      {
        name: 'GAIN_BAND_5',
        description: 'Gain state for Band 5. (L = Low gain, H = High)',
        type: 'STRING',
      },
      {
        name: 'GAIN_BAND_6',
        description: 'Gain state for Band 6. (L = Low gain, H = High)',
        type: 'STRING',
      },
      {
        name: 'GAIN_BAND_7',
        description: 'Gain state for Band 7. (L = Low gain, H = High)',
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
        name: 'GEOMETRIC_RMSE_VERIFY',
        description: |||
          RMSE of the geometric residuals (pixels) in both line and sample
          directions measured on the terrain-corrected product independently
          using GLS2000.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_LL',
        description: |||
          RMSE of the geometric residuals (pixels) of the lower-left quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_LR',
        description: |||
          RMSE of the geometric residuals (pixels) of the lower-right quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_UL',
        description: |||
          RMSE of the geometric residuals (pixels) of the upper-left quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_UR',
        description: |||
          RMSE of the geometric residuals (pixels) of the upper-right quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'GRID_CELL_SIZE_REFLECTIVE',
        description: 'Grid cell size used in creating the image for the reflective band.',
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
        name: 'GROUND_CONTROL_POINTS_VERIFY',
        description: |||
          The number of ground control points used in the verification of
          the terrain corrected product. Values: -1 to 1615 (-1 = not available)
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
        name: 'IMAGE_QUALITY',
        description: 'Image quality, 0 = worst, 9 = best, -1 = quality not calculated',
        type: 'DOUBLE',
      },
      {
        name: 'LANDSAT_PRODUCT_ID',
        description: |||
          The naming convention of each Landsat Collection 1 Level-1 image based
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
          *  CC = Collection Number (01)
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
        name: 'MAP_PROJECTION_L0RA',
        description: |||
          L0RA map projection selectively applied to HDTs based on geographic location. Used for processed archive data.
        |||,
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
        name: 'PRESENT_BAND_4',
        description: 'Presence of Band 4 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: 'STRING',
      },
      {
        name: 'PRESENT_BAND_5',
        description: 'Presence of Band 5 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: 'STRING',
      },
      {
        name: 'PRESENT_BAND_6',
        description: 'Presence of Band 6 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: 'STRING',
      },
      {
        name: 'PRESENT_BAND_7',
        description: 'Presence of Band 7 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: 'STRING',
      },
      {
        name: 'PROCESSING_LEVEL',
        description: 'One of L1GS, L1GT, or L1TP.',
        type: 'DOUBLE',
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description: 'Name and version of the processing software used to generate the L1 product.',
        type: 'STRING',
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
        name: 'REFLECTANCE_ADD_BAND_6',
        description: 'Additive rescaling factor used to convert calibrated Band 6 DN to reflectance.',
        type: 'DOUBLE',
      },
      {
        name: 'REFLECTANCE_ADD_BAND_7',
        description: 'Additive rescaling factor used to convert calibrated Band 7 DN to reflectance.',
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
          World Reference System (WRS) type used 
          for the collection of this scene.
        |||,
        type: 'DOUBLE',
      },
    ],
    'eo:bands': [
      {
        name: 'B4',
        description: 'Green',
        center_wavelength: 0.55,
        gsd: 60.0,
        'gee:wavelength': '0.5 - 0.6 &mu;m',
      },
      {
        name: 'B5',
        description: 'Red',
        center_wavelength: 0.65,
        gsd: 60.0,
        'gee:wavelength': '0.6 - 0.7 &mu;m',
      },
      {
        name: 'B6',
        description: 'Near Infrared 1',
        center_wavelength: 0.75,
        gsd: 60.0,
        'gee:wavelength': '0.7 - 0.8 &mu;m',
      },
      {
        name: 'B7',
        description: 'Near Infrared 2',
        center_wavelength: 0.95,
        gsd: 30.0,
        'gee:wavelength': '0.8 - 1.1 &mu;m',
      },
    ] + common_bands.common_bands_mss,
    'gee:visualizations': [
      {
        display_name: 'Near Infrared (321)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'B6',
              'B5',
              'B4',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (421)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'B7',
              'B5',
              'B4',
            ],
          },
        },
      },
    ],
  },
}
