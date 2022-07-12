local id = 'LANDSAT/LM5';
local successor_id = 'LANDSAT/LM05/C01/T1';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS Landsat 5 MSS Raw Scenes [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 5 MSS DN values, representing scaled, calibrated at-sensor radiance.

    As of May 1, 2017, the USGS is no longer producing Pre-Collection Landsat, and therefore this collection is complete. Please switch to a Collection 1-based dataset. See [this documentation page](https://developers.google.com/earth-engine/landsat) for more information.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'global',
    'l5',
    'landsat',
    'lm5',
    'mss',
    'radiance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://landsat.usgs.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-03-04T18:17:36Z', '2013-01-07T17:52:14Z'),
  summaries: {
    'gee:schema': [
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
        description: 'Tier of scene. (T1 or T2)',
        type: ee_const.var_type.string,
      },
      {
        name: 'COLLECTION_NUMBER',
        description: 'Number of collection.',
        type: ee_const.var_type.double,
      },
      {
        name: 'CORRECTION_GAIN_BAND_1',
        description: 'Internal calibration gain method for band 1.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_2',
        description: 'Internal calibration gain method for band 2.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_3',
        description: 'Internal calibration gain method for band 3.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_4',
        description: 'Internal calibration gain method for band 4.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CPF_NAME',
        description: 'Calibration parameter file name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_CATEGORY',
        description: |||
          Current data category assigned to the data. Possible values:
          ("NOMINAL", "VALIDATION", "EXCHANGE", "TEST", "ENGINEERING")
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_TYPE',
        description: 'Data type identifier. (L1T or L1G)',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATA_TYPE_L0RP',
        description: 'Data type identifier string used to create the L0RP product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATE_ACQUIRED',
        description: 'Image acquisition date. "YYYY-MM-DD"',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATUM',
        description: 'Datum used in image creation.',
        type: ee_const.var_type.string,
      },
      {
        name: 'EARTH_SUN_DISTANCE',
        description: 'Earth sun distance in astronomical units (AU).',
        type: ee_const.var_type.double,
      },
      {
        name: 'ELEVATION_SOURCE',
        description: 'Elevation model source used for standard terrain corrected (L1T) products.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ELLIPSOID',
        description: 'Ellipsoid used in image creation.',
        type: ee_const.var_type.string,
      },
      {
        name: 'EPHEMERIS_TYPE',
        description: 'Ephemeris data type used to perform geometric correction. (Definitive or Predictive)',
        type: ee_const.var_type.string,
      },
      {
        name: 'FILE_DATE',
        description: 'File date in milliseconds since epoch.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_BAND_1',
        description: 'Gain state for Band 1. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_2',
        description: 'Gain state for Band 2. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_3',
        description: 'Gain state for Band 3. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_4',
        description: 'Gain state for Band 4. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL',
        description: |||
          Combined Root Mean Square Error (RMSE) of the geometric residuals
          (metres) in both across-track and along-track directions
          measured on the GCPs used in geometric precision correction.
          Not present in L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_X',
        description: |||
          RMSE of the X direction geometric residuals (in metres) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_Y',
        description: |||
          RMSE of the Y direction geometric residuals (in metres) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY',
        description: |||
          RMSE of the geometric residuals (pixels) in both line and sample
          directions measured on the terrain-corrected product independently
          using GLS2000.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_LL',
        description: |||
          RMSE of the geometric residuals (pixels) of the lower-left quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_LR',
        description: |||
          RMSE of the geometric residuals (pixels) of the lower-right quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_UL',
        description: |||
          RMSE of the geometric residuals (pixels) of the upper-left quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_VERIFY_QUAD_UR',
        description: |||
          RMSE of the geometric residuals (pixels) of the upper-right quadrant
          measured on the terrain-corrected product independently using GLS2000.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GRID_CELL_SIZE_REFLECTIVE',
        description: 'Grid cell size used in creating the image for the reflective band.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_MODEL',
        description: |||
          The number of ground control points used. Not used in L1GT products.
          Values: 0 - 999 (0 is used for L1T products that have used
          Multi-scene refinement).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_VERIFY',
        description: |||
          The number of ground control points used in the verification of
          the terrain corrected product. Values: -1 to 1615 (-1 = not available)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUND_CONTROL_POINTS_VERSION',
        description: |||
          The number of ground control points used in the verification of
          the terrain corrected product. Values: -1 to 1615 (-1 = not available)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'IMAGE_QUALITY',
        description: 'Image quality, 0 = worst, 9 = best, -1 = quality not calculated',
        type: ee_const.var_type.double,
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
        type: ee_const.var_type.string,
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
        type: ee_const.var_type.string,
      },
      {
        name: 'MAP_PROJECTION',
        description: 'Projection used to represent the 3-dimensional surface of the earth for the Level-1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MAP_PROJECTION_L0RA',
        description: |||
          L0RA map projection selectively applied to HDTs based on geographic location. Used for processed archive data.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ORIENTATION',
        description: |||
          Orientation used in creating the image. Values: NOMINAL = Nominal Path, NORTH_UP = North Up, TRUE_NORTH = True North, USER = User
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PRESENT_BAND_1',
        description: 'Presence of Band 1 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRESENT_BAND_2',
        description: 'Presence of Band 2 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRESENT_BAND_3',
        description: 'Presence of Band 3 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRESENT_BAND_4',
        description: 'Presence of Band 4 (Y = Yes, N = No, M = Missing, I = Unknown)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description: 'Name and version of the processing software used to generate the L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'RADIANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated DN\nto radiance for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated DN\nto radiance for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated DN\nto radiance for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated DN\nto radiance for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_1',
        description: 'Multiplicative rescaling factor used to convert\ncalibrated Band 1 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_2',
        description: 'Multiplicative rescaling factor used to convert\ncalibrated Band 2 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_3',
        description: 'Multiplicative rescaling factor used to convert\n calibrated Band 3 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_4',
        description: 'Multiplicative rescaling factor used to convert\ncalibrated Band 4 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated\nBand 1 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated\nBand 2 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated\nBand 3 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated\nBand 4 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_1',
        description: 'Multiplicative factor used to convert calibrated\nBand 1 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_2',
        description: 'Multiplicative factor used to convert calibrated\nBand 2 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_3',
        description: 'Multiplicative factor used to convert calibrated\nBand 3 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_4',
        description: 'Multiplicative factor used to convert calibrated\nBand 4 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTIVE_LINES',
        description: 'Number of product lines for the reflective bands.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTIVE_SAMPLES',
        description: 'Number of product samples for the reflective bands.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REQUEST_ID',
        description: 'Request id, nnnyymmdd0000_0000\n\n*  nnn = node number\n*  yy = year\n*  mm = month\n*  dd = day',
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_OPTION',
        description: 'Resampling option used in creating the image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_1',
        description: "Flag indicating saturated pixels for band 1 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_2',
        description: "Flag indicating saturated pixels for band 2 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_3',
        description: "Flag indicating saturated pixels for band 3 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_4',
        description: "Flag indicating saturated pixels for band 4 ('Y'/'N')",
        type: ee_const.var_type.string,
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
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_ID',
        description: 'Sensor used to capture data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPACECRAFT_ID',
        description: 'Spacecraft identification.',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATION_ID',
        description: 'Ground Station/Organisation that received the data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SUN_AZIMUTH',
        description: 'Sun azimuth angle in degrees for the image center location at the image centre acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SUN_ELEVATION',
        description: 'Sun elevation angle in degrees for the image center location at the image centre acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'UTM_ZONE',
        description: 'UTM zone number used in product map projection.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WRS_PATH',
        description: 'The WRS orbital path number (001 - 251).',
        type: ee_const.var_type.double,
      },
      {
        name: 'WRS_ROW',
        description: 'Landsat satellite WRS row (001-248).',
        type: ee_const.var_type.double,
      },
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Green',
        center_wavelength: 0.55,
        gsd: 60.0,
        'gee:wavelength': '0.5 - 0.6 &mu;m',
      },
      {
        name: 'B2',
        description: 'Red',
        center_wavelength: 0.65,
        gsd: 60.0,
        'gee:wavelength': '0.6 - 0.7 &mu;m',
      },
      {
        name: 'B3',
        description: 'Near Infrared 1',
        center_wavelength: 0.75,
        gsd: 60.0,
        'gee:wavelength': '0.7 - 0.8 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near Infrared 2',
        center_wavelength: 0.95,
        gsd: 30.0,
        'gee:wavelength': '0.8 - 1.1 &mu;m',
      },
      {
        name: 'BQA',
        description: |||
          Landsat Collection 1 QA Bitmask
          ([See Landsat QA page](https://www.usgs.gov/land-resources/nli/landsat/landsat-collection-1-level-1-quality-assessment-band))
        |||,
        gsd: 60.0,
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
              description: 'Dropped Pixel',
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
          ],
          total_bit_count: 5,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Near Infrared (321)',
        image_visualization: {
          band_vis: {
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (421)',
        image_visualization: {
          band_vis: {
            bands: [
              'B4',
              'B2',
              'B1',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
  version: 'Unknown',
}
