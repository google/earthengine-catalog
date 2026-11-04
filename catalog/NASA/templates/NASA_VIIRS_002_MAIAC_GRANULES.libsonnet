local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

{
  summaries: {
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'Optical_Depth_047',
        description: |||
          Aerosol optical depth over land and ocean retrieved in the VIIRS Blue
          band (0.47 &mu;m). AOD is not retrieved at high altitude (greater than
          4.2 km over land or 3.5 km over water) except when smoke or dust is
          detected; rather, a static climatology value of 0.02 is reported for
          atmospheric correction.
        |||,
        gsd: 750.0,
        'gee:scale': 0.001,
        center_wavelength: 0.47,
      },
      {
        name: 'Optical_Depth_055',
        description: |||
          Aerosol optical depth over land and ocean retrieved in the VIIRS Green
          band (0.55 &mu;m).
        |||,
        gsd: 750.0,
        'gee:scale': 0.001,
        center_wavelength: 0.55,
      },
      {
        name: 'AOD_Uncertainty',
        description: |||
          AOD uncertainty based on blue-band surface brightness (reflectance).
        |||,
        gsd: 750.0,
        'gee:scale': 0.0001,
      },
      {
        name: 'FineModeFraction',
        description: 'Fine mode fraction for ocean and large inland lakes.',
        gsd: 750.0,
        'gee:scale': 0.0001,
      },
      {
        name: 'AngstromExp_470_860',
        description: 'Angstrom exponent 470-860nm over the ocean.',
        gsd: 750.0,
        'gee:scale': 0.0001,
      },
      {
        name: 'AOD_QA',
        description: 'AOD quality assurance flags.',
        gsd: 750.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud mask',
              bit_count: 3,
              values: [
                {
                  description: 'Undefined',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Clear',
                },
                {
                  value: 2,
                  description: 'Possibly cloudy (detected by AOD filter)',
                },
                {
                  value: 3,
                  description: 'Cloudy (detected by cloud mask algorithm)',
                },
                {
                  value: 4,
                  description: 'Turbid water',
                },
                {
                  value: 5,
                  description: 'Cloud shadow',
                },
                {
                  value: 6,
                  description: 'Hot spot of fire',
                },
                {
                  value: 7,
                  description: 'Water sediments',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Land water snow/ice mask',
              first_bit: 3,
              bit_count: 2,
              values: [
                {
                  description: 'Land',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Water',
                },
                {
                  value: 2,
                  description: 'Snow',
                },
                {
                  value: 3,
                  description: 'Ice',
                },
              ],
            },
            {
              description: 'Adjacency mask',
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'Normal condition/Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Adjacent to clouds',
                },
                {
                  value: 2,
                  description: 'Surrounded by more than 4 cloudy pixels',
                },
                {
                  value: 3,
                  description: 'Adjacent to a single cloudy pixel',
                },
                {
                  value: 4,
                  description: 'Adjacent to snow',
                },
                {
                  value: 5,
                  description: 'Snow was previously detected in this pixel',
                },
              ],
            },
            {
              description: 'QA for AOD',
              first_bit: 8,
              bit_count: 4,
              values: [
                {
                  description: 'Best quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Water sediments are detected (water)',
                },
                {
                  value: 3,
                  description: 'There is 1 neighbor cloud',
                },
                {
                  value: 4,
                  description: 'There is >1 neighbor clouds',
                },
                {
                  value: 5,
                  description: 'No retrieval (cloudy, or whatever)',
                },
                {
                  value: 6,
                  description: |||
                    No retrievals near detected or previously detected snow
                  |||,
                },
                {
                  value: 7,
                  description: |||
                    Climatology AOD: altitude above 3.5km (water) and 4.2km
                    (land)
                  |||,
                },
                {
                  value: 8,
                  description: 'No retrieval due to sun glint (water)',
                },
                {
                  value: 9,
                  description: |||
                    Retrieved AOD is very low (<0.05) due to glint (water)
                  |||,
                },
                {
                  value: 10,
                  description: |||
                    AOD within +-2km from the coastline is replaced by nearby
                    AOD
                  |||,
                },
              ],
            },
            {
              description: 'Aerosol model',
              first_bit: 12,
              bit_count: 2,
              values: [
                {
                  description: 'Background model (regional)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Smoke model (regional)',
                  },
                {
                  value: 2,
                  description: 'Dust model',
                },
              ],
            },
            {
              description: 'Smoke injection height',
              first_bit: 14,
              bit_count: 2,
              values: [
                {
                  description: 'No injection height is retrieved',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Background is acquired from band M15',
                },
                {
                  value: 2,
                  description: 'Background is acquired from GDAS profile',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'Injection_Height',
        description: 'Smoke injection height above local surface height.',
        gsd: 750.0,
        'gee:units': units.meter,
      },
      {
        name: 'cosSZA',
        description: 'Cosine of solar zenith angle (3.75 km resolution).',
        gsd: 3750.0,
        'gee:scale': 0.0001,
      },
      {
        name: 'cosVZA',
        description: 'Cosine of view zenith angle (3.75 km resolution).',
        gsd: 3750.0,
        'gee:scale': 0.0001,
      },
      {
        name: 'RelAZ',
        description: 'Relative azimuth angle (3.75 km resolution).',
        gsd: 3750.0,
        'gee:scale': 0.01,
        'gee:units': units.degree,
      },
      {
        name: 'Scattering_Angle',
        description: 'Scattering angle (3.75 km resolution).',
        gsd: 3750.0,
        'gee:scale': 0.01,
        'gee:units': units.degree,
      },
      {
        name: 'Glint_Angle',
        description: 'Glint angle (3.75 km resolution).',
        gsd: 3750.0,
        'gee:scale': 0.01,
        'gee:units': units.degree,
      },
    ],
    'gee:schema': [
      {
        name: 'AlgorithmVersion',
        description: 'The algorithm package version used to generate the product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'LocalGranuleID',
        description: 'Local granule ID of the source HDF-EOS5 file.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PGEVersion',
        description: 'Product Generation Executive (PGE) version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PlatformShortName',
        description: 'Satellite platform short name (SUOMI-NPP or JPSS-1).',
        type: ee_const.var_type.string,
      },
      {
        name: 'ProductionTime',
        description: 'Granule production timestamp (milliseconds since Unix epoch).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SATELLITE',
        description: 'Satellite platform short name (SUOMI-NPP or JPSS-1).',
        type: ee_const.var_type.string,
      },
      {
        name: 'ShortName',
        description: 'Product short name (VNP19A2 or VJ119A2).',
        type: ee_const.var_type.string,
      },
      {
        name: 'VersionID',
        description: 'Collection version ID (002).',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Optical Depth 047',
        lookat: {
          lat: 13.0,
          lon: 76.0,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'Optical_Depth_047',
            ],
            min: [
              0.0,
            ],
            max: [
              500.0,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
          },
        },
      },
    ],
    Optical_Depth_047: {
      minimum: 0,
      maximum: 6000,
      'gee:estimated_range': false,
    },
    Optical_Depth_055: {
      minimum: 0,
      maximum: 6000,
      'gee:estimated_range': false,
    },
    AOD_Uncertainty: {
      minimum: 0,
      maximum: 10000,
      'gee:estimated_range': false,
    },
    FineModeFraction: {
      minimum: 0,
      maximum: 10000,
      'gee:estimated_range': false,
    },
    AngstromExp_470_860: {
      minimum: -5000,
      maximum: 30000,
      'gee:estimated_range': false,
    },
    Injection_Height: {
      minimum: 0,
      maximum: 10000,
      'gee:estimated_range': false,
    },
    cosSZA: {
      minimum: 0,
      maximum: 10000,
      'gee:estimated_range': false,
    },
    cosVZA: {
      minimum: 0,
      maximum: 10000,
      'gee:estimated_range': false,
    },
    RelAZ: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
    Scattering_Angle: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
    Glint_Angle: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
  },
}
