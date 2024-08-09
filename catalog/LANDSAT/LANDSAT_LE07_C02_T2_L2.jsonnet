local id = 'LANDSAT/LE07/C02/T2_L2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'landsat.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local notes = import 'templates/LANDSAT_L2.libsonnet';

local license = spdx.proprietary {
  reference: 'https://www.usgs.gov/centers/eros/data-citation',
};

local versions = import 'versions.libsonnet';
local version_table = import 'LE7_T2_L2_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 7 Level 2, Collection 2, Tier 2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains atmospherically corrected
    surface reflectance and land surface temperature derived from the data
    produced by the Landsat 7 ETM+ sensor.
    These images contain 4 visible and near-infrared (VNIR) bands and
    2 short-wave infrared (SWIR) bands processed to orthorectified surface
    reflectance, and one thermal infrared (TIR) band processed to orthorectified
    surface temperature. They also contain intermediate bands used in
    calculation of the ST products, as well as QA bands.

    Landsat 7 SR products are created with the Landsat Ecosystem Disturbance
    Adaptive Processing System (LEDAPS) algorithm (version 3.4.0).
    All Collection 2 ST products are created with a single-channel algorithm
    jointly created by the Rochester Institute of Technology (RIT) and
    National Aeronautics and Space Administration (NASA)
    Jet Propulsion Laboratory (JPL).

    Strips of collected data are packaged into overlapping \"scenes\" covering approximately
    170km x 183km using a [standardized reference grid](https://landsat.gsfc.nasa.gov/about/worldwide-reference-system).

    Some assets have only SR data, in which case ST bands are present but empty.
    For assets with both ST and SR bands, 'PROCESSING_LEVEL' is set to 'L2SP'.
    For assets with only SR bands, 'PROCESSING_LEVEL' is set to 'L2SR'.

    [Additional documentation and usage examples.](/earth-engine/guides/landsat)

  ||| + notes.description + landsat.l7_drift,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'cfmask',
    'cloud',
    'etm',
    'fmask',
    'global',
    'landsat',
    'lasrc',
    'le07',
    'lst',
    'reflectance',
    'sr',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collection-2-level-2-science-products'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1999-05-28T01:06:16Z', null),
  summaries: {
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
        name: 'GROUND_CONTROL_POINTS_MODEL',
        description: |||
          Number of GCPs used in the precision correction process.
          This parameter is only present if the L1_PROCESSING_LEVEL is L1TP.
        |||,
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
        name: 'IMAGE_QUALITY',
        description: 'Composite image quality for the bands.\n0 = worst, 9 = best, -1 = quality not calculated or assessed.',
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
        name: 'TEMPERATURE_MAXIMUM_BAND_ST_B6',
        description: 'Maximum achievable temperature value for Band 6.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TEMPERATURE_MINIMUM_BAND_ST_B6',
        description: 'Minimum achievable temperature value for Band 6.',
        type: ee_const.var_type.double,
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
        description: 'Band 1 (blue) surface reflectance',
        center_wavelength: 0.485,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.45-0.52 &mu;m',
      },
      {
        name: 'SR_B2',
        description: 'Band 2 (green) surface reflectance',
        center_wavelength: 0.56,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.52-0.60 &mu;m',
      },
      {
        name: 'SR_B3',
        description: 'Band 3 (red) surface reflectance',
        center_wavelength: 0.66,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.63-0.69 &mu;m',
      },
      {
        name: 'SR_B4',
        description: 'Band 4 (near infrared) surface reflectance',
        center_wavelength: 0.835,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '0.77-0.90 &mu;m',
      },
      {
        name: 'SR_B5',
        description: 'Band 5 (shortwave infrared 1) surface reflectance',
        center_wavelength: 1.65,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '1.55-1.75 &mu;m',
      },
      {
        name: 'SR_B7',
        description: 'Band 7 (shortwave infrared 2) surface reflectance',
        center_wavelength: 2.215,
        'gee:scale': 2.75e-05,
        'gee:offset': -0.2,
        'gee:wavelength': '2.08-2.35 &mu;m',
      },
      {
        name: 'SR_ATMOS_OPACITY',
        description: |||
          A general interpretation of atmospheric opacity
          generated by LEDAPS and based on the radiance viewed over Dark Dense
          Vegetation (DDV) within the scene. A general interpretation of atmospheric
          opacity is that values (after scaling by 0.001 is applied)
          less than 0.1 are clear, 0.1-0.3 are average,
          and values greater than 0.3 indicate haze or other cloud situations.
          SR values from pixels with high atmospheric opacity will be less reliable,
          especially under high solar zenith angle conditions. The
          SR_ATMOS_OPACITY band is provided for advanced users and for product quality
          assessment and has not been validated. Most users are advised to instead use
          the QA_PIXEL band information for cloud discrimination.
        |||,
        'gee:scale': 0.001,
      },
      {
        name: 'SR_CLOUD_QA',
        description: 'Cloud Quality Assessment',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Dark Dense Vegetation (DDV)',
              bit_count: 1,
              first_bit: 0,
            },
            {
              description: 'Cloud',
              first_bit: 1,
              bit_count: 1,
            },
            {
              description: 'Cloud Shadow',
              first_bit: 2,
              bit_count: 1,
            },
            {
              description: 'Adjacent to Cloud',
              first_bit: 3,
              bit_count: 1,
            },
            {
              description: 'Snow',
              first_bit: 4,
              bit_count: 1,
            },
            {
              description: 'Water',
              first_bit: 5,
              bit_count: 1,
            },
          ],
          total_bit_count: 6,
        },
      },
      {
        name: 'ST_B6',
        description: "Band 6 surface temperature. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': units.kelvin,
        center_wavelength: 11.45,
        'gee:scale': 0.00341802,
        'gee:offset': 149.0,
        'gee:wavelength': '10.40-12.50 &mu;m',
      },
      {
        name: 'ST_ATRAN',
        description: "Atmospheric Transmittance. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_CDIST',
        description: "Pixel distance to cloud. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': units.kilometer,
        'gee:scale': 0.01,
      },
      {
        name: 'ST_DRAD',
        description: "Downwelled Radiance. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:units': 'W/(m^2*sr*um)/ DN',
        'gee:scale': 0.001,
      },
      {
        name: 'ST_EMIS',
        description: |||
          Emissivity estimated from ASTER GED. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_EMSD',
        description: "Emissivity standard deviation. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.",
        'gee:scale': 0.0001,
      },
      {
        name: 'ST_QA',
        description: |||
          Uncertainty of the Surface Temperature band. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
        |||,
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
      },
      {
        name: 'ST_TRAD',
        description: |||
          Thermal band converted to radiance. If 'PROCESSING_LEVEL' is set to 'L2SR', this band is fully masked out.
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
            },
            {
              description: 'Dilated Cloud',
              first_bit: 1,
              bit_count: 1,
            },
            {
              description: 'Unused',
              first_bit: 2,
              bit_count: 1,
            },
            {
              description: 'Cloud',
              first_bit: 3,
              bit_count: 1,
            },
            {
              description: 'Cloud Shadow',
              first_bit: 4,
              bit_count: 1,
            },
            {
              description: 'Snow',
              first_bit: 5,
              bit_count: 1,
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
            },
            {
              description: 'Band 2 data saturated',
              first_bit: 1,
              bit_count: 1,
            },
            {
              description: 'Band 3 data saturated',
              first_bit: 2,
              bit_count: 1,
            },
            {
              description: 'Band 4 data saturated',
              first_bit: 3,
              bit_count: 1,
            },
            {
              description: 'Band 5 data saturated',
              first_bit: 4,
              bit_count: 1,
            },
            {
              description: 'Band 6L data saturated',
              first_bit: 5,
              bit_count: 1,
            },
            {
              description: 'Band 7 data saturated',
              first_bit: 6,
              bit_count: 1,
            },
            {
              description: 'Unused',
              first_bit: 7,
              bit_count: 1,
            },
            {
              description: 'Band 6H data saturated',
              first_bit: 8,
              bit_count: 1,
            },
            {
              description: 'Dropped pixel',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel present',
                  value: 0,
                },
                {
                  value: 1,
                  description: "Detector doesn't have a value",
                },
              ],
            },
          ],
          total_bit_count: 10,
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
              'SR_B3',
              'SR_B2',
              'SR_B1',
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
              'SR_B4',
              'SR_B3',
              'SR_B2',
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
              'SR_B7',
              'SR_B4',
              'SR_B2',
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
    SR_B7: {
      minimum: 1.0,
      maximum: 65455.0,
      'gee:estimated_range': false,
    },
    SR_ATMOS_OPACITY: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    ST_B6: {
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
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
