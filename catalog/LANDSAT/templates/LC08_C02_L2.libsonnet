local ee_const = import 'earthengine_const.libsonnet';

{
  summaries : {
    'gee:schema': [
      {
        name: 'ALGORITHM_SOURCE_SURFACE_REFLECTANCE',
        description: 'Name and version of the surface reflectance algorithm.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ALGORITHM_SOURCE_SURFACE_TEMPERATURE',
        description: 'Name and version of the surface temperature algorithm.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CLOUD_COVER',
        description: 'Percentage cloud cover (0-100), -1 = not calculated.',
        type: ee_const.var_type.double,
      },
      {
        name: 'CLOUD_COVER_LAND',
        description: 'Percentage cloud cover over land (0-100), -1 = not calculated.',
        type: ee_const.var_type.double,
      },
      {
        name: 'COLLECTION_CATEGORY',
        description: 'Scene collection category, "T1" or "T2".',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_AIR_TEMPERATURE',
        description: 'Air temperature data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_ELEVATION',
        description: 'Elevation data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_OZONE',
        description: 'Ozone data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_PRESSURE',
        description: 'Pressure data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_REANALYSIS',
        description: 'Reanalysis data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_TIRS_STRAY_LIGHT_CORRECTION',
        description: 'TIRS stray light correction data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_SOURCE_WATER_VAPOR',
        description: 'Water vapor data source.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATE_PRODUCT_GENERATED',
        description: 'Timestamp of the date when the product was generated.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EARTH_SUN_DISTANCE',
        description: 'Earth-Sun distance (AU).',
        type: ee_const.var_type.double,
      },
      {
        name: 'EPHEMERIS_TYPE',
        description: |||
          Identifier to inform the user of the orbital ephemeris type used:
          "DEFINITIVE" or "PREDICTIVE". If the field is not present, the user should
          assume "PREDICTIVE".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL',
        description: |||
          Combined RMSE (Root Mean Square Error) of the geometric
          residuals (meters) in both across-track and along-track
          directions. This parameter is only present if the L1_PROCESSING_LEVEL
          is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_X',
        description: |||
          RMSE (Root Mean Square Error) of the geometric residuals (meters)
          measured on the GCPs (Ground Control Points) used in geometric
          precision correction in the across-track direction. This parameter is
          only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_Y',
        description: |||
          RMSE (Root Mean Square Error) of the geometric residuals (meters)
          measured on the GCPs (Ground Control Points) used in geometric
          precision correction in the along-track direction. This parameter is
          only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY',
        description: |||
          RMSE of the geometric residuals (meters) measured on the
          terrain-corrected product independently using GLS2000. This parameter
          is only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_MODEL',
        description: |||
          Number of GCPs used in the precision correction process.
          This parameter is only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_VERIFY',
        description: 'Number of GCPs (Ground Control Points) used in the verification\nof the terrain corrected product.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_VERSION',
        description: |||
          GCP dataset version used in the precision correction process. This
          parameter is only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'IMAGE_QUALITY_OLI',
        description: |||
          Image quality of the OLI bands.
          1 = worst, 9 = best, 0 = quality not calculated.
          For Landsat 8, this parameter is adjusted downward for
          scenes collected using the lower 12 bits from the OLI sensor
          (TRUNCATION_OLI = "LOWER").
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'IMAGE_QUALITY_TIRS',
        description: |||
          Image quality of the TIRS bands.
          1 = worst, 9 = best, 0 = quality not calculated.
          It is also adjusted downward for scenes processed with
          "SWITCHED" for the TIRS_SSM_POSITION_STATUS value.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'L1_DATE_PRODUCT_GENERATED',
        description: 'Product generation date for the corresponding L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'L1_LANDSAT_PRODUCT_ID',
        description: 'Landsat Product Identifier for the corresponding L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'L1_PROCESSING_LEVEL',
        description: 'Processing Level for the corresponding L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'L1_PROCESSING_SOFTWARE_VERSION',
        description: 'Processing software version for the corresponding L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'LANDSAT_PRODUCT_ID',
        description: 'Landsat Product Identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'LANDSAT_SCENE_ID',
        description: 'Short Landsat Scene Identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_LEVEL',
        description: '"L2SP" when both SR and LST bands are present, or "L2SR" when only\nSR bands are present.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description: 'The processing software version that created the product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ROLL_ANGLE',
        description: |||
          The amount of spacecraft roll angle at the scene center. The roll value is
          given in the Yaw Steering Frame (YSF) reference, whose x-axis is
          aligned with the instantaneous ground track velocity vector. Rolls about
          this x-axis go by the right-hand rule: a positive roll results in the
          instruments pointing to the left of the ground track, while a negative
          roll results in the instrument pointing to the right.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SCENE_CENTER_TIME',
        description: 'Time of the observations as in ISO 8601 string.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_ID',
        description: 'Name of the sensor.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPACECRAFT_ID',
        description: 'Name of the spacecraft.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SUN_AZIMUTH',
        description: |||
          Sun azimuth angle in degrees for the image center location at the
          image center acquisition time. A positive value indicates angles to the
          east or clockwise from the north. A negative value indicates angles to
          the west or counterclockwise from the north.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SUN_ELEVATION',
        description: |||
          Sun elevation angle in degrees for the image center location at the
          image center acquisition time. A positive value indicates a daytime
          scene. A negative value indicates a nighttime scene.
          Note: For reflectance calculation, the sun zenith angle is needed,
          which is 90 - sun elevation angle.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'TARGET_WRS_PATH',
        description: 'Nearest WRS-2 path to the Line-ofSight (LOS) scene center of the image.',
        type: ee_const.var_type.int,
      },
      {
        name: 'TARGET_WRS_ROW',
        description: |||
          Nearest WRS-2 row to the LOS scene center of the image. Rows 880-889
          are reserved for the north pole and 990-999 are reserved for the south
          pole, where WRS-2 is not defined.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'TEMPERATURE_MAXIMUM_BAND_ST_B10',
        description: 'Maximum achievable temperature value for Band 10.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TEMPERATURE_MINIMUM_BAND_ST_B10',
        description: 'Minimum achievable temperature value for Band 10.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TIRS_SSM_MODEL',
        description: |||
          Indicates how the Landsat 8 TIRS Scene Select Mirror (SSM) position
          was determined.

          * "FINAL" indicates final estimated encoder values generated after
          the switch event.

          * "ACTUAL" indicates actual encoder values.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TIRS_SSM_POSITION_STATUS',
        description: |||
          * "NOMINAL" indicates the SSM was functioning normally for this scene.

          * "SWITCHED" indicates the SSM switched operating modes in the scene and
          may have TIRS image quality issues, which directly impact the
          IMAGE_QUALITY_TIRS value.

          * "ESTIMATED" indicates the SSM position was estimated, which may not be
          as accurate as the "NOMINAL" status.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TRUNCATION_OLI',
        description: |||
          * "LOWER" indicates that the lower 12 bits were used.

          * "UPPER" indicates the upper 12 bits were used.

          The normal truncation mode is "UPPER".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'WRS_PATH',
        description: 'WRS path number of scene.',
        type: ee_const.var_type.int,
      },
      {
        name: 'WRS_ROW',
        description: 'WRS row number of scene.',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'SR_B1',
        description: 'Band 1 (ultra blue, coastal aerosol) surface reflectance',
        center_wavelength: 0.443,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.435-0.451 &mu;m',
      },
      {
        name: 'SR_B2',
        description: 'Band 2 (blue) surface reflectance',
        center_wavelength: 0.482,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.452-0.512 &mu;m',
      },
      {
        name: 'SR_B3',
        description: 'Band 3 (green) surface reflectance',
        center_wavelength: 0.562,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.533-0.590 &mu;m',
      },
      {
        name: 'SR_B4',
        description: 'Band 4 (red) surface reflectance',
        center_wavelength: 0.655,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.636-0.673 &mu;m',
      },
      {
        name: 'SR_B5',
        description: 'Band 5 (near infrared) surface reflectance',
        center_wavelength: 0.865,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.851-0.879 &mu;m',
      },
      {
        name: 'SR_B6',
        description: 'Band 6 (shortwave infrared 1) surface reflectance',
        center_wavelength: 1.609,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '1.566-1.651 &mu;m',
      },
      {
        name: 'SR_B7',
        description: 'Band 7 (shortwave infrared 2) surface reflectance',
        center_wavelength: 2.201,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '2.107-2.294 &mu;m',
      },
      {
        name: 'SR_QA_AEROSOL',
        description: 'Aerosol attributes',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Fill',
              bit_count: 1,
              first_bit: 0,
              values: [],
            },
            {
              description: 'Aerosol retrieval - valid',
              first_bit: 1,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Water pixel',
              first_bit: 2,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Unused',
              first_bit: 3,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Unused',
              first_bit: 4,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Interpolated Aerosol',
              first_bit: 5,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Aerosol Level',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'ST_B10',
        description: "Band 10 surface temperature.\nIf 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': 'Kelvin',
        center_wavelength: 10.895,
        'gee:scale': 0.00341802,
        'gee:offset': 149.0,
        'gee:wavelength': '10.60-11.19 &mu;m',
      },
      {
        name: 'ST_ATRAN',
        description: "Atmospheric Transmittance.\nIf 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_CDIST',
        description: "Pixel distance to cloud.\nIf 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': 'km',
        'gee:scale': 0.01,
      },
      {
        name: 'ST_DRAD',
        description: "Downwelled Radiance.\nIf 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': 'W/(m^2*sr*um)/ DN',
        'gee:scale': 0.001,
      },
      {
        name: 'ST_EMIS',
        description: |||
          Emissivity of Band 10 estimated from ASTER GED.
          If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_EMSD',
        description: "Emissivity standard deviation.\nIf 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_QA',
        description: |||
          Uncertainty of the Surface Temperature band.
          If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
        |||,
        'gee:units': 'K',
        'gee:scale': 0.01,
      },
      {
        name: 'ST_TRAD',
        description: |||
          Thermal band converted to radiance.
          If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
        |||,
        'gee:units': 'W/(m^2*sr*um)/ DN',
        'gee:scale': 0.001,
      },
      {
        name: 'ST_URAD',
        description: "Upwelled Radiance. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': 'W/(m^2*sr*um)/ DN',
        'gee:scale': 0.001,
      },
      {
        name: 'QA_PIXEL',
        description: 'Pixel quality attributes generated from the CFMASK algorithm.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Fill',
              bit_count: 1,
              first_bit: 0,
              values: [],
            },
            {
              description: 'Dilated Cloud',
              first_bit: 1,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Cirrus (high confidence)',
              first_bit: 2,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Cloud',
              first_bit: 3,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Cloud Shadow',
              first_bit: 4,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Snow',
              first_bit: 5,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Clear',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Cloud or Dilated Cloud bits are set',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud and Dilated Cloud bits are not set',
                },
              ],
            },
            {
              description: 'Water',
              first_bit: 7,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Cloud Confidence',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cloud Shadow Confidence',
              first_bit: 10,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Snow/Ice Confidence',
              first_bit: 12,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cirrus Confidence',
              first_bit: 14,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'QA_RADSAT',
        description: 'Radiometric saturation QA',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Band 1 data saturated',
              bit_count: 1,
              first_bit: 0,
              values: [],
            },
            {
              description: 'Band 2 data saturated',
              first_bit: 1,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 3 data saturated',
              first_bit: 2,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 4 data saturated',
              first_bit: 3,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 5 data saturated',
              first_bit: 4,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 6 data saturated',
              first_bit: 5,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 7 data saturated',
              first_bit: 6,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Unused',
              first_bit: 7,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Band 9 data saturated',
              first_bit: 8,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Unused',
              first_bit: 9,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Unused',
              first_bit: 10,
              bit_count: 1,
              values: [],
            },
            {
              description: 'Terrain occlusion',
              first_bit: 11,
              bit_count: 1,
              values: [],
            },
          ],
          total_bit_count: 12,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (432)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'SR_B4',
              'SR_B3',
              'SR_B2',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (543)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'SR_B5',
              'SR_B4',
              'SR_B3',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (753)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30000.0,
            ],
            bands: [
              'SR_B7',
              'SR_B5',
              'SR_B3',
            ],
          },
        },
      },
    ],
    SR_B1: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B2: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B3: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B4: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B5: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B6: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_B7: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    ST_B10: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    ST_ATRAN: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    ST_CDIST: {
      minimum: 0.0,
      maximum: 24000.0,
      'gee:estimated_range': false,
    },
    ST_DRAD: {
      minimum: 0.0,
      maximum: 28000.0,
      'gee:estimated_range': false,
    },
    ST_EMIS: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    ST_EMSD: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    ST_QA: {
      minimum: 0.0,
      maximum: 32767.0,
      'gee:estimated_range': false,
    },
    ST_TRAD: {
      minimum: 0.0,
      maximum: 22000.0,
      'gee:estimated_range': false,
    },
    ST_URAD: {
      minimum: 0.0,
      maximum: 28000.0,
      'gee:estimated_range': false,
    },
  }
}
