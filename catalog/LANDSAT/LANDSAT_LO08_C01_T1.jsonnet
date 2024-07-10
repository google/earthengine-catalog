local id = 'LANDSAT/LO08/C01/T1';

local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local versions = import 'versions.libsonnet';
local version_table = import 'LO8_T1_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
{
  "gee:skip_indexing": true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS Landsat 8 Collection 1 Tier 1 OLI Raw Scenes [deprecated]',
  version: version,
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 8 Collection 1 Tier 1 OLI DN values, representing scaled, calibrated at-sensor radiance.
  ||| + landsat.tier1,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'c1',
    'global',
    'l8',
    'landsat',
    'lo8',
    'oli',
    'radiance',
    't1',
    'tier1',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/land-resources/nli/landsat/landsat-8-data-users-handbook'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2013-04-01T13:46:38Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'BPF_NAME_OLI',
        description: |||
          The file name for the Bias Parameter File (BPF) used to generate the product, if applicable. This only applies to products that contain OLI bands.
        |||,
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
        description: 'Tier of scene. (T1 or T2)',
        type: ee_const.var_type.string,
      },
      {
        name: 'COLLECTION_NUMBER',
        description: 'Number of collection.',
        type: ee_const.var_type.double,
      },
      {
        name: 'CPF_NAME',
        description: 'Calibration parameter file name.',
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
        name: 'GROUND_CONTROL_POINTS_MODEL',
        description: |||
          The number of ground control points used. Not used in L1GT products.
          Values: 0 - 999 (0 is used for L1T products that have used
          Multi-scene refinement).
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
        name: 'IMAGE_QUALITY_OLI',
        description: |||
          The composite image quality for the OLI bands. Values: 9 = Best. 1 = Worst. 0 = Image quality not calculated. This parameter is only present if OLI bands are present in the product.
        |||,
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
        name: 'NADIR_OFFNADIR',
        description: 'Nadir or Off-Nadir condition of the scene.',
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
        name: 'RADIANCE_ADD_BAND_6',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 6.',
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
        name: 'RADIANCE_ADD_BAND_9',
        description: 'Additive rescaling factor used to convert calibrated DN to radiance for Band 9.',
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
        name: 'RADIANCE_MULT_BAND_6',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 6 DN to radiance.',
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
        name: 'RADIANCE_MULT_BAND_9',
        description: 'Multiplicative rescaling factor used to convert calibrated Band 9 DN to radiance.',
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
        description: 'Multiplicative factor used to convert calibrated Band 7 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_8',
        description: 'Multiplicative factor used to convert calibrated Band 8 DN to reflectance.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REFLECTANCE_ADD_BAND_9',
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
        name: 'REFLECTANCE_MULT_BAND_6',
        description: 'Multiplicative factor used to convert calibrated Band 6 DN to reflectance.',
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
        name: 'REFLECTANCE_MULT_BAND_9',
        description: 'Multiplicative factor used to convert calibrated Band 9 DN to reflectance.',
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
        name: 'RLUT_FILE_NAME',
        description: |||
          The file name for the Response Linearization Lookup Table (RLUT) used to generate the product, if applicable.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ROLL_ANGLE',
        description: 'The amount of spacecraft roll angle at the scene center.',
        type: ee_const.var_type.double,
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
        name: 'SATURATION_BAND_6',
        description: "Flag indicating saturated pixels for band 6 ('Y'/'N')",
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
        name: 'SATURATION_BAND_9',
        description: "Flag indicating saturated pixels for band 9 ('Y'/'N')",
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
        description: 'Sun azimuth angle in degrees for the image center location at the image center acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SUN_ELEVATION',
        description: 'Sun elevation angle in degrees for the image center location at the image center acquisition time.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TARGET_WRS_PATH',
        description: 'Nearest WRS-2 path to the line-of-sight scene center of the image.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TARGET_WRS_ROW',
        description: |||
          Nearest WRS-2 row to the line-of-sight scene center of the image. Rows 880-889 and 990-999 are reserved for the polar regions where it is undefined in the WRS-2.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'TRUNCATION_OLI',
        description: 'Region of OLCI truncated.',
        type: ee_const.var_type.string,
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
        name: 'BQA',
        description: |||
          Landsat Collection 1 QA Bitmask
          ([See Landsat QA page](https://www.usgs.gov/land-resources/nli/landsat/landsat-collection-1-level-1-quality-assessment-band))
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
              description: 'Terrain Occlusion',
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
            {
              description: 'Cirrus Confidence',
              first_bit: 11,
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
          total_bit_count: 13,
        },
      },
    ],
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
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
