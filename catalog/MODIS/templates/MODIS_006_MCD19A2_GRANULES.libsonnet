local units = import 'units.libsonnet';

{
  summaries: {
    gsd: [
      1000.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Optical_Depth_047',
        description: 'Blue band (0.47 &mu;m) aerosol optical depth over land',
        'gee:scale': 0.001,
      },
      {
        name: 'Optical_Depth_055',
        description: 'Green band (0.55 &mu;m) aerosol optical depth over land',
        'gee:scale': 0.001,
      },
      {
        name: 'AOD_Uncertainty',
        description: 'AOD uncertainty based on blue-band surface brightness (reflectance)',
        'gee:scale': 0.0001,
      },
      {
        name: 'FineModeFraction',
        description: 'Fine mode fraction for ocean',
        'gee:scale': 0.0001,
      },
      {
        name: 'Column_WV',
        description: 'Column water vapor over land',
        'gee:units': 'cm',
        'gee:scale': 0.001,
      },
      {
        name: 'AOD_QA',
        description: 'AOD QA',
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
                  description: 'Surrounded by more than 8 cloudy pixels',
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
                  description: 'Water Sediments are detected (water)',
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
                  description: 'No retrievals near detected or previously detected snow',
                },
                {
                  value: 7,
                  description: 'Climatology AOD - altitude above 3.5km (water) and 4.2km (land)',
                },
                {
                  value: 8,
                  description: 'No retrieval due to sun glint (water)',
                },
                {
                  value: 9,
                  description: 'Retrieved AOD is very low (<0.05) due to glint (water)',
                },
                {
                  value: 10,
                  description: 'AOD within +-2km from the coastline (may be unreliable)',
                },
                {
                  value: 11,
                  description: 'Land, research quality - AOD retrieved but CM is possibly cloudy',
                },
              ],
            },
            {
              description: 'Glint mask',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'No glint',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Glint (glint angle < 40&deg;)',
                },
              ],
            },
            {
              description: 'Aerosol model',
              first_bit: 13,
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
              description: 'Reserved',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'Reserved for future use',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Reserved for future use',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'AOD_MODEL',
        description: 'AOD model used in retrieval',
      },
      {
        name: 'Injection_Height',
        description: 'Smoke injection height',
        'gee:units': units.meters,
      },
      {
        name: 'cosSZA',
        description: 'Cosine of solar zenith angle (5 km resolution)',
        'gee:scale': 0.0001,
      },
      {
        name: 'cosVZA',
        description: 'Cosine view zenith angle (5 km resolution)',
        'gee:scale': 0.0001,
      },
      {
        name: 'RelAZ',
        description: 'Relative azimuth angle (5 km resolution)',
        'gee:scale': 0.01,
      },
      {
        name: 'Scattering_Angle',
        description: 'Scattering angle (5 km resolution)',
        'gee:scale': 0.01,
      },
      {
        name: 'Glint_Angle',
        description: 'Glint angle (5 km resolution)',
        'gee:scale': 0.01,
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
              'Optical_Depth_047'
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
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Optical_Depth_055: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    AOD_Uncertainty: {
      minimum: -100.0,
      maximum: 30000.0,
      'gee:estimated_range': false,
    },
    FineModeFraction: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Column_WV: {
      minimum: 0.0,
      maximum: 30000.0,
      'gee:estimated_range': false,
    },
    AOD_MODEL: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Injection_Height: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    cosSZA: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    cosVZA: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    RelAZ: {
      minimum: -18000.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    Scattering_Angle: {
      minimum: -18000.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    Glint_Angle: {
      minimum: -18000.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
  },

}
