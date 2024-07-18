local id = 'LANDSAT/LE7_L1T_TOA';

local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local versions = import 'versions.libsonnet';
local version_table = import 'LE7_PRE_L1T_TOA_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  'gee:skip_indexing': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS Landsat 7 TOA Reflectance (Orthorectified) [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 7 calibrated top-of-atmosphere reflectance,
    orthorectified scenes only. For recently-acquired scenes calibration
    coefficients are extracted from the image metadata; for older scenes the
    coefficients are derived from [Chander et al.
    (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'global',
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS/Google', 'https://landsat.usgs.gov/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1999-05-28T01:02:17Z', '2017-04-30T23:47:21Z'),
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
        name: 'CORRECTION_BIAS_BAND_1',
        description: 'Internal calibration bias method for band 1.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_2',
        description: 'Internal calibration bias method for band 2.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_3',
        description: 'Internal calibration bias method for band 3.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_4',
        description: 'Internal calibration bias method for band 4.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_5',
        description: 'Internal calibration bias method for band 5.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_6_VCID_1',
        description: 'Internal calibration bias method for band 6_VICD_1.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_6_VCID_2',
        description: 'Internal calibration bias method for band 6_VICD_2.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_7',
        description: 'Internal calibration bias method for band 7.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_BIAS_BAND_8',
        description: 'Internal calibration bias method for band 8.',
        type: ee_const.var_type.string,
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
        name: 'CORRECTION_GAIN_BAND_5',
        description: 'Internal calibration gain method for band 5.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_6_VCID_1',
        description: 'Internal calibration gain method for band 6_VCID_1.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_6_VCID_2',
        description: 'Internal calibration gain method for band 6_VCID_2.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_7',
        description: 'Internal calibration gain method for band 7.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CORRECTION_GAIN_BAND_8',
        description: 'Internal calibration gain method for band 8.',
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
        name: 'GAIN_BAND_5',
        description: 'Gain state for Band 5. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_6_VCID_1',
        description: 'Gain state for Band 6 VCID_1. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_6_VCID_2',
        description: 'Gain state for Band 6 VCID_2. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_7',
        description: 'Gain state for Band 7. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_BAND_8',
        description: 'Gain state for Band 8. (L = Low gain, H = High)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_1',
        description: |||
          Presence and direction of gain change for Band 1 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_2',
        description: |||
          Presence and direction of gain change for Band 2 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_3',
        description: |||
          Presence and direction of gain change for Band 3 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_4',
        description: |||
          Presence and direction of gain change for Band 4 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_5',
        description: |||
          Presence and direction of gain change for Band 5 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_6_VCID_1',
        description: |||
          Presence and direction of gain change for Band 6 VCID_1 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_6_VCID_2',
        description: |||
          Presence and direction of gain change for Band 6 VCID_2 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_7',
        description: |||
          Presence and direction of gain change for Band 7 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_BAND_8',
        description: |||
          Presence and direction of gain change for Band 8 (LL = no
          change, HH = no change, LH = low to high, HL = high to low, U = Unknown).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_1',
        description: 'Scan line number where the first change in Band 1 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_2',
        description: 'Scan line number where the first change in Band 2 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_3',
        description: 'Scan line number where the first change in Band 3 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_4',
        description: 'Scan line number where the first change in Band 4 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_5',
        description: 'Scan line number where the first change in Band 5 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_6_VCID_1',
        description: 'Scan line number where the first change in Band 6 VCID 1 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_6_VCID_2',
        description: 'Scan line number where the first change in Band 6 VCID 2 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_7',
        description: 'Scan line number where the first change in Band 7 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_CHANGE_SCAN_BAND_8',
        description: 'Scan line number where the first change in Band 8 gain was detected.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL',
        description: |||
          Combined Root Mean Square Error (RMSE) of the geometric residuals
          (meters) in both across-track and along-track directions
          measured on the GCPs used in geometric precision correction.
          Not present in L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_X',
        description: |||
          RMSE of the X direction geometric residuals (in meters) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_RMSE_MODEL_Y',
        description: |||
          RMSE of the Y direction geometric residuals (in meters) measured
          on the GCPs used in geometric precision correction. Not present in
          L1G products.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GRID_CELL_SIZE_PANCHROMATIC',
        description: 'Grid cell size used in creating the image for the panchromatic band.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GRID_CELL_SIZE_REFLECTIVE',
        description: 'Grid cell size used in creating the image for the reflective band.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GRID_CELL_SIZE_THERMAL',
        description: 'Grid cell size used in creating the image for the thermal band.',
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
        name: 'K1_CONSTANT_BAND_6_VCID_1',
        description: 'Calibration K1 constant for Band 6 VCID 1 radiance to temperature conversion.',
        type: ee_const.var_type.double,
      },
      {
        name: 'K1_CONSTANT_BAND_6_VCID_2',
        description: 'Calibration K1 constant for Band 6 VCID 2 radiance to temperature conversion.',
        type: ee_const.var_type.double,
      },
      {
        name: 'K2_CONSTANT_BAND_6_VCID_1',
        description: 'Calibration K2 constant for Band 6 VCID 1 radiance to temperature conversion.',
        type: ee_const.var_type.double,
      },
      {
        name: 'K2_CONSTANT_BAND_6_VCID_2',
        description: 'Calibration K2 constant for Band 6 VCID 2 radiance to temperature conversion.',
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
          L0RA map projection selectively applied to HDTs based on
          geographic location. Used for processed archive data.
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
        name: 'PANCHROMATIC_LINES',
        description: 'Number of product lines for the panchromatic band.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PANCHROMATIC_SAMPLES',
        description: 'Number of product samples for the panchromatic bands.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description: 'Name and version of the processing software used to generate the L1 product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'RADIANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_5',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 5.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_6_VCID_1',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 6 VCID 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_6_VCID_2',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 6 VCID 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_7',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 7.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_ADD_BAND_8',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 8.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_1',
        description: 'Maximum achievable spectral radiance value for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_2',
        description: 'Maximum achievable spectral radiance value for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_3',
        description: 'Maximum achievable spectral radiance value for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_4',
        description: 'Maximum achievable spectral radiance value for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_5',
        description: 'Maximum achievable spectral radiance value for Band 5.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_6_VCID_1',
        description: 'Maximum achievable spectral radiance value for Band 6 VCID 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_6_VCID_2',
        description: 'Maximum achievable spectral radiance value for Band 6 VCID 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_7',
        description: 'Maximum achievable spectral radiance value for Band 7.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MAXIMUM_BAND_8',
        description: 'Maximum achievable spectral radiance value for Band 8.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_1',
        description: 'Minimum achievable spectral radiance value for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_2',
        description: 'Minimum achievable spectral radiance value for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_3',
        description: 'Minimum achievable spectral radiance value for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_4',
        description: 'Minimum achievable spectral radiance value for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_5',
        description: 'Minimum achievable spectral radiance value for Band 5.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_6_VCID_1',
        description: 'Minimum achievable spectral radiance value for Band 6 VCID 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_6_VCID_2',
        description: 'Minimum achievable spectral radiance value for Band 6 VCID 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_7',
        description: 'Minimum achievable spectral radiance value for Band 7.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MINIMUM_BAND_8',
        description: 'Minimum achievable spectral radiance value for Band 8.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_1',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 1 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_2',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 2 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_3',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 3 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_4',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 4 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_5',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 5 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_6_VCID_1',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 6 VCID 1 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_6_VCID_2',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 6 VCID 2 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_7',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 7 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIANCE_MULT_BAND_8',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 8 DN to radiance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_1',
        description: 'Additive rescaling factor used to convert calibrated Band 1 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_2',
        description: 'Additive rescaling factor used to convert calibrated Band 2 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_3',
        description: 'Additive rescaling factor used to convert calibrated Band 3 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_4',
        description: 'Additive rescaling factor used to convert calibrated Band 4 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_5',
        description: 'Additive rescaling factor used to convert calibrated Band 5 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_7',
        description: 'Additive rescaling factor used to convert calibrated Band 7 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_8',
        description: 'Additive rescaling factor used to convert calibrated Band 8 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_1',
        description: 'Maximum achievable spectral reflectance value for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_2',
        description: 'Maximum achievable spectral reflectance value for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_3',
        description: 'Maximum achievable spectral reflectance value for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_4',
        description: 'Maximum achievable spectral reflectance value for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_5',
        description: 'Maximum achievable spectral reflectance value for Band 5.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_7',
        description: 'Maximum achievable spectral reflectance value for Band 7.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MAXIMUM_BAND_8',
        description: 'Maximum achievable spectral reflectance value for Band 8.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_1',
        description: 'Minimum achievable spectral reflectance value for Band 1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_2',
        description: 'Minimum achievable spectral reflectance value for Band 2.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_3',
        description: 'Minimum achievable spectral reflectance value for Band 3.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_4',
        description: 'Minimum achievable spectral reflectance value for Band 4.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_5',
        description: 'Minimum achievable spectral reflectance value for Band 5.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_7',
        description: 'Minimum achievable spectral reflectance value for Band 7.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MINIMUM_BAND_8',
        description: 'Minimum achievable spectral reflectance value for Band 8.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_1',
        description: 'Multiplicative factor used to convert calibrated Band 1 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_2',
        description: 'Multiplicative factor used to convert calibrated Band 2 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_3',
        description: 'Multiplicative factor used to convert calibrated Band 3 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_4',
        description: 'Multiplicative factor used to convert calibrated Band 4 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_5',
        description: 'Multiplicative factor used to convert calibrated Band 5 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_7',
        description: 'Multiplicative factor used to convert calibrated Band 7 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_MULT_BAND_8',
        description: 'Multiplicative factor used to convert calibrated Band 8 DN to reflectance.',
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
        name: 'SATURATION_BAND_5',
        description: "Flag indicating saturated pixels for band 5 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_6_VCID_1',
        description: "Flag indicating saturated pixels for band 6 VCID 1 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_6_VCID_2',
        description: "Flag indicating saturated pixels for band 6 VCID 2 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_7',
        description: "Flag indicating saturated pixels for band 7 ('Y'/'N')",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATURATION_BAND_8',
        description: "Flag indicating saturated pixels for band 8 ('Y'/'N')",
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
        name: 'SENSOR_MODE',
        description: 'Operational mode. Scan Angle Monitor (SAM) or BUMPER.',
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
        description: 'Sun azimuth angle in degrees for the image center location at the image center acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SUN_ELEVATION',
        description: 'Sun elevation angle in degrees for the image center location at the image center acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'THERMAL_LINES',
        description: 'Number of product lines for the thermal band.',
        type: ee_const.var_type.double,
      },
      {
        name: 'THERMAL_SAMPLES',
        description: 'Number of product samples for the thermal band.',
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
        'gee:wavelength': '0.77 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B6_VCID_1',
        description: |||
          Low-gain Thermal Infrared 1. This band has expanded dynamic range
          and lower radiometric resolution (sensitivity), with less
          saturation at high Digital Number (DN) values. Resampled from
          60m to 30m.
        |||,
        center_wavelength: 11.45,
        gsd: 60.0,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: 'B6_VCID_2',
        description: |||
          High-gain Thermal Infrared 1. This band has higher radiometric
          resolution (sensitivity), although it has a more restricted dynamic range.
          Resampled from 60m to 30m.
        |||,
        center_wavelength: 11.45,
        gsd: 60.0,
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
        name: 'B8',
        description: 'Panchromatic',
        center_wavelength: 0.71,
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.90 &mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        image_visualization: {
          band_vis: {
            gamma: [
              1.2,
            ],
            gain: [
              600.0,
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
        image_visualization: {
          band_vis: {
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
        image_visualization: {
          band_vis: {
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
  version: version,
}
