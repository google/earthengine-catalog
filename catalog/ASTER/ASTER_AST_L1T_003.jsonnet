local id = 'ASTER/AST_L1T_003';
local subdir = 'ASTER';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ASTER L1T Radiance',
  version: 'V003',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Advanced Spaceborne Thermal Emission and Reflection Radiometer (ASTER)
    is a multispectral imager that was launched on board NASA's Terra spacecraft
    in December, 1999. ASTER can collect data in 14 spectral bands from the
    visible to the thermal infrared. Each scene covers an area of 60 x 60 km.
    These scenes, produced by the USGS, contain calibrated at-sensor radiance,
    ortho-rectified and terrain corrected.

    Not all 14 bands were collected in each scene. An asset property named
    ORIGINAL_BANDS_PRESENT contains the list of bands that are present in each
    scene.

    To convert from Digital Numbers (DN) to radiance at the sensor, the unit
    conversion coefficients are available in the metadata. See
    [ASTER L1T Product Users' Guide](https://lpdaac.usgs.gov/documents/647/AST__L1T_User_Guide_V3.pdf)
    and [ASTER L1T Product Specification](https://lpdaac.usgs.gov/documents/300/ASTER_L1T_Product_Specification.pdf)
    for more information.

    Documentation:

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/72/AST_L1T_ATBD.pdf)

    * [User's Guide](https://lpdaac.usgs.gov/documents/647/AST__L1T_User_Guide_V3.pdf)

    * [ASTER Level-1T Product Specification](https://lpdaac.usgs.gov/documents/300/ASTER_L1T_Product_Specification.pdf)

    * [ASTER L1T Quick Reference Guide(ASTER L1T Quick Reference Guide)](https://lpdaac.usgs.gov/documents/174/AST_L1T_Quick_Reference_Guide.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ASTER/AST_L1T.003',
    },
  ],
  keywords: [
    'aster',
    'eos',
    'imagery',
    'nasa',
    'nir',
    'radiance',
    'swir',
    'terra',
    'thermal',
    'tir',
    'toa',
    'usgs',
    'vnir',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/ASTER/AST_L1T.003'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000320-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-03-04T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'BAD_PIXELS_B01',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B02',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B03',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B04',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B05',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B06',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B07',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B08',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B09',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B10',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B11',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B12',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B13',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'BAD_PIXELS_B14',
        description: 'Number of bad pixels',
        type: ee_const.var_type.double,
      },
      {
        name: 'CLOUDCOVER',
        description: 'Cloud coverage',
        type: ee_const.var_type.double,
      },
      {
        name: 'COARSE_DEM_DATE',
        description: 'Coarse DEM issuance date',
        type: ee_const.var_type.string,
      },
      {
        name: 'COARSE_DEM_NOTE',
        description: 'Coarse DEM comments',
        type: ee_const.var_type.string,
      },
      {
        name: 'COARSE_DEM_VERSION',
        description: 'Coarse DEM version number',
        type: ee_const.var_type.string,
      },
      {
        name: 'FLYING_DIRECTION',
        description: |||
          The satellite flight direction when observation is done: 'AS' - ascending
          direction, 'DE' - descending direction
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_COEFFICIENT_B01',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B02',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B03',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B04',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B05',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B06',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B07',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B08',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B09',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B10',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B11',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B12',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B13',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_COEFFICIENT_B14',
        description: 'Coefficient used for radiance conversion',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAIN_SETTING_B01',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B02',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B03',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B04',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B05',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B06',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B07',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B08',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B09',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B10',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B11',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B12',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B13',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GAIN_SETTING_B14',
        description: "Band gain setting: 'HGH' - high, 'NOR' - normal, 'LOW' - low, 'LO1'\n- low 1, or 'LO2' - low 2",
        type: ee_const.var_type.string,
      },
      {
        name: 'GCP_CHIPS_CORRELATED',
        description: 'How many chips correlated during correlation statistics creation',
        type: ee_const.var_type.double,
      },
      {
        name: 'GEOMETRIC_DB_DATE',
        description: 'Geometric correction data issuance date',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOMETRIC_DB_VERSION',
        description: 'Geometric correction data version number',
        type: ee_const.var_type.string,
      },
      {
        name: 'GRANULE_REPROCESSING',
        description: |||
          What reprocessing has been performed on the granule: 'not reprocessed',
          'reprocessed once', 'reprocessed twice', or 'reprocessing n times'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ORBIT_NUMBER',
        description: 'The orbit number of the satellite when data is acquired',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORIGINAL_BANDS_PRESENT',
        description: 'List of bands that are present in each scene',
        type: ee_const.var_type.double,
      },
      {
        name: 'PGE_VERSION',
        description: 'The version of PGE',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCTION_TIME',
        description: 'Generation time of this product',
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_PERCENT_INTERPOLATED_DATA',
        description: 'The percentage of interpolated data in the scene',
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_PERCENT_MISSING_DATA',
        description: 'The percentage of missing data in the scene',
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_PERCENT_OUT_OF_BOUNDS_DATA',
        description: 'The percentage of out of bounds data in the scene',
        type: ee_const.var_type.double,
      },
      {
        name: 'RADIOMETRIC_DB_DATE',
        description: 'Radiometric correction data issuance date',
        type: ee_const.var_type.string,
      },
      {
        name: 'RADIOMETRIC_DB_VERSION',
        description: 'Radiometric correction data version number',
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B01',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B02',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B03',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B04',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B05',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B06',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B07',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B08',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B09',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B10',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B11',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B12',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B13',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'RESAMPLING_METHOD_B14',
        description: "Resampling method: 'BL', 'NN', or 'CC'",
        type: ee_const.var_type.string,
      },
      {
        name: 'SATELLITE_RECURRENT_CYCLENUMBER',
        description: 'The satellite recurrent cycle number',
        type: ee_const.var_type.double,
      },
      {
        name: 'SATELLITE_REVOLUTION_NUMBER',
        description: 'The satellite revolution number in the cycle',
        type: ee_const.var_type.double,
      },
      {
        name: 'SCENE_PATH',
        description: 'Scene path',
        type: ee_const.var_type.double,
      },
      {
        name: 'SCENE_ROW',
        description: 'Scene row',
        type: ee_const.var_type.double,
      },
      {
        name: 'SCENE_VIEW',
        description: 'Scene view',
        type: ee_const.var_type.double,
      },
      {
        name: 'SOLAR_AZIMUTH',
        description: |||
          Sun direction as seen from the scene center; azimuth angle in
          degrees measured eastward from North (0.0<az<360)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SOLAR_ELEVATION',
        description: 'Sun direction as seen from the scene center; elevation angle in degrees (-90.0<el<90.0)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SOURCE_DATA_GRANULE',
        description: 'ID of input AST_L1A data granule used for generating this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'SWIR_POINTING_ANGLE',
        description: 'Pointing angle in degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'TIR_POINTING_ANGLE',
        description: 'Pointing angle in degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'VNIR_POINTING_ANGLE',
        description: 'Pointing angle in degrees',
        type: ee_const.var_type.double,
      },
    ],
    platform: [
      'Terra',
    ],
    instruments: [
      'ASTER',
    ],
    'eo:bands': [
      {
        name: 'B01',
        description: 'VNIR_Band1 (visible green/yellow)',
        center_wavelength: 0.56,
        gsd: 15.0,
        'gee:wavelength': '0.520-0.600&mu;m',
      },
      {
        name: 'B02',
        description: 'VNIR_Band2 (visible red)',
        center_wavelength: 0.66,
        gsd: 15.0,
        'gee:wavelength': '0.630-0.690&mu;m',
      },
      {
        name: 'B3N',
        description: 'VNIR_Band3N (near infrared, nadir pointing)',
        center_wavelength: 0.82,
        gsd: 15.0,
        'gee:wavelength': '0.780-0.860&mu;m',
      },
      {
        name: 'B04',
        description: 'SWIR_Band4 (short-wave infrared)',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.600-1.700&mu;m',
      },
      {
        name: 'B05',
        description: 'SWIR_Band5 (short-wave infrared)',
        center_wavelength: 2.165,
        gsd: 30.0,
        'gee:wavelength': '2.145-2.185&mu;m',
      },
      {
        name: 'B06',
        description: 'SWIR_Band6 (short-wave infrared)',
        center_wavelength: 2.205,
        gsd: 30.0,
        'gee:wavelength': '2.185-2.225&mu;m',
      },
      {
        name: 'B07',
        description: 'SWIR_Band7 (short-wave infrared)',
        center_wavelength: 2.26,
        gsd: 30.0,
        'gee:wavelength': '2.235-2.285&mu;m',
      },
      {
        name: 'B08',
        description: 'SWIR_Band8 (short-wave infrared)',
        center_wavelength: 2.33,
        gsd: 30.0,
        'gee:wavelength': '2.295-2.365&mu;m',
      },
      {
        name: 'B09',
        description: 'SWIR_Band9 (short-wave infrared)',
        center_wavelength: 2.395,
        gsd: 30.0,
        'gee:wavelength': '2.360-2.430&mu;m',
      },
      {
        name: 'B10',
        description: 'TIR_Band10 (thermal infrared)',
        center_wavelength: 8.3,
        gsd: 90.0,
        'gee:wavelength': '8.125-8.475&mu;m',
      },
      {
        name: 'B11',
        description: 'TIR_Band11 (thermal infrared)',
        center_wavelength: 8.65,
        gsd: 90.0,
        'gee:wavelength': '8.475-8.825&mu;m',
      },
      {
        name: 'B12',
        description: 'TIR_Band12 (thermal infrared)',
        center_wavelength: 9.11,
        gsd: 90.0,
        'gee:wavelength': '8.925-9.275&mu;m',
      },
      {
        name: 'B13',
        description: 'TIR_Band13 (thermal infrared)',
        center_wavelength: 10.6,
        gsd: 90.0,
        'gee:wavelength': '10.250-10.950&mu;m',
      },
      {
        name: 'B14',
        description: 'TIR_Band14 (thermal infrared)',
        center_wavelength: 11.3,
        gsd: 90.0,
        'gee:wavelength': '10.950-11.650&mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lat: 39.6734,
          lon: -122.0272,
          zoom: 11,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'B3N',
              'B02',
              'B01',
            ],
          },
        },
      },
    ],
    B01: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B02: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B3N: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B04: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B05: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B06: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B07: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B08: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B09: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B10: {
      minimum: 1.0,
      maximum: 4095.0,
      'gee:estimated_range': false,
    },
    B11: {
      minimum: 1.0,
      maximum: 4095.0,
      'gee:estimated_range': false,
    },
    B12: {
      minimum: 1.0,
      maximum: 4095.0,
      'gee:estimated_range': false,
    },
    B13: {
      minimum: 1.0,
      maximum: 4095.0,
      'gee:estimated_range': false,
    },
    B14: {
      minimum: 1.0,
      maximum: 4095.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/ASTER/AST_L1T.003',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    ASTER data and products distributed by the LP DAAC, with the exception of
    the ASTER Global Digital Elevation Model (GDEM) dataset (ASTGTM) version 2
    (v2), have no restrictions on data use, sale, or subsequent redistribution.
  |||,
}
