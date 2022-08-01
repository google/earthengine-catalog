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
        name: 'CORRECTION_BIAS_BAND_1',
        description: 'Internal calibration bias method for band 1.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_2',
        description: 'Internal calibration bias method for band 2.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_3',
        description: 'Internal calibration bias method for band 3.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_4',
        description: 'Internal calibration bias method for band 4.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_5',
        description: 'Internal calibration bias method for band 5.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_6',
        description: 'Internal calibration bias method for band 6.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_BIAS_BAND_7',
        description: 'Internal calibration bias method for band 7.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_1',
        description: 'Internal calibration gain method for band 1.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_2',
        description: 'Internal calibration gain method for band 2.',
        type: 'STRING',
      },
      {
        name: 'CORRECTION_GAIN_BAND_3',
        description: 'Internal calibration gain method for band 3.',
        type: 'STRING',
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
        name: 'CPF_NAME',
        description: 'Calibration parameter file name.',
        type: 'STRING',
      },
      {
        name: 'DATA_CATEGORY',
        description: |||
          Current data category assigned to the data. Possible values: ("NOMINAL", "VALIDATION", "EXCHANGE", "TEST", "ENGINEERING")
        |||,
        type: 'STRING',
      },
      {
        name: 'DATA_TYPE',
        description: 'Data type identifier. (L1T or L1G)',
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
        name: 'ELEVATION_SOURCE',
        description: 'Elevation model source used for standard terrain corrected (L1T) products.',
        type: 'STRING',
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
        name: 'FILE_DATE',
        description: 'File date in milliseconds since epoch.',
        type: 'DOUBLE',
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
        name: 'K1_CONSTANT_BAND_6',
        description: 'Calibration constant K1 for Band 6 radiance to temperature conversion.',
        type: 'DOUBLE',
      },
      {
        name: 'K2_CONSTANT_BAND_6',
        description: 'Calibration constant K2 for Band 6 radiance to temperature conversion.',
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
        name: 'RADIANCE_MULT_BAND_1',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 1 DN to radiance.',
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
        name: 'SATURATION_BAND_1',
        description: "Flag indicating saturated pixels for band 1 ('Y'/'N')",
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
        name: 'SENSOR_MODE',
        description: 'Operational mode. Scan Angle Monitor (SAM) or BUMPER.',
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
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.76 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B6',
        description: 'Thermal Infrared 1. Resampled from 60m to 30m.',
        center_wavelength: 11.45,
        gsd: 30.0,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
      {
        name: 'BQA',
        description: |||
          Landsat Collection 1 QA Bitmask ([See Landsat QA page](https://www.usgs.gov/land-resources/nli/landsat/landsat-collection-1-level-1-quality-assessment-band))
        |||,
        gsd: 30.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Designated Fill',
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
              description: 'Designated Pixel',
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
              description: 'Radiometric Saturation',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'No bands contain saturation',
                  value: 0,
                },
                {
                  value: 1,
                  description: '1-2 bands contain saturation',
                },
                {
                  value: 2,
                  description: '3-4 bands contain saturation',
                },
                {
                  value: 3,
                  description: '5 or more bands contain saturation',
                },
              ],
            },
            {
              description: 'Cloud',
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
              description: 'Cloud Confidence',
              first_bit: 5,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
            {
              description: 'Cloud Shadow Confidence',
              first_bit: 7,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
            {
              description: 'Snow / Ice Confidence',
              first_bit: 9,
              bit_count: 2,
              values: [
                {
                  description: 'Not Determined / Condition does not exist.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low, (0-33 percent confidence)',
                },
                {
                  value: 2,
                  description: 'Medium, (34-66 percent confidence)',
                },
                {
                  value: 3,
                  description: 'High, (67-100 percent confidence)',
                },
              ],
            },
          ],
          total_bit_count: 11,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (432)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.4,
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
        display_name: 'Shortwave Infrared (742)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.8,
              1.9,
              1.9,
            ],
            bands: [
              'B7',
              'B4',
              'B2',
            ],
          },
        },
      },
    ],
  },
}
