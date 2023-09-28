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
        name: 'Sur_refl1',
        description: |||
          Surface reflectance at 500m for band 1.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl2',
        description: |||
          Surface reflectance at 500m for band 2.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl3',
        description: |||
          Surface reflectance at 500m for band 3.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl4',
        description: |||
          Surface reflectance at 500m for band 4.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl5',
        description: |||
          Surface reflectance at 500m for band 5.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl6',
        description: |||
          Surface reflectance at 500m for band 6.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl7',
        description: |||
          Surface reflectance at 500m for band 7.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl8',
        description: |||
          Surface reflectance at 1km for band 8.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl9',
        description: |||
          Surface reflectance at 1km for band 9.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl10',
        description: |||
          Surface reflectance at 1km for band 10.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl11',
        description: |||
          Surface reflectance at 1km for band 11.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sur_refl12',
        description: |||
          Surface reflectance at 1km for band 12.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sigma_BRFn1',
        description: |||
           BRFn uncertainty over time at 1km, for band 1
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Sigma_BRFn2',
        description: 'BRFn uncertainty over time at 1km, for band 2',
        'gee:scale': 0.0001,
      },
      {
        name: 'Status_QA',
        description: 'QA bits',
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
              description: 'AOD level',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'AOD is low  (<=0.6)',
                  value: 0,
                },
                {
                  description: 'AOD is high (> 0.6) or undefined',
                  value: 1,
                },
              ],
            },
            {
              description: 'AOD Type',
              first_bit: 9,
              bit_count: 2,
              values: [
                {
                  description: 'Background aerosol',
                  value: 0,
                },
                {
                  description: 'Smoke',
                  value: 1,
                },
                {
                  description: 'Dust',
                  value: 2,
                },
              ],
            },
            {
              description: 'BRF retrieved over snow assuming AOD = 0.05',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'no',
                  value: 0,
                },
                {
                  description: 'yes',
                  value: 1,
                },
              ],
            },
            {
              description: |||
                Altitude >4.2km (land)/3.5km (water), BRF is retrieved using
                climatology AOD =0.02
              |||,
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'no',
                  value: 0,
                },
                {
                  description: 'yes',
                  value: 1,
                },
              ],
            },
            {
              description: 'Surface Change Mask',
              first_bit: 13,
              bit_count: 3,
              values: [
                {
                  description: 'No change',
                  value: 0,
                },
                {
                  description: |||
                    Regular change Green up (Relative change in Red and NIR
                    nadir-normalized BRF is more than 5% but less than 15%).
                  |||,
                  value: 1,
                },
                {
                  description: |||
                    Big change Green up (Relative change in Red and NIR
                    nadir-normalized BRF is more than 15%).
                  |||,
                  value: 2,
                },
                {
                  description: 'Regular change Senescence',
                  value: 3,
                },
                {
                  description: 'Big change Senescence',
                  value: 4,
                },
              ],
            },
          ],
          total_bit_count: 16
        },
      },
      {
        name: 'cosSZA',
        description: 'Cosine of Solar zenith angle (5 km resulution)',
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
        name: 'SAZ',
        description: 'Solar Azimuth Angle (5 km resolution)',
        'gee:scale': 0.01,
      },
      {
        name: 'VAZ',
        description: 'View Azimuth Angle (5 km resolution)',
        'gee:scale': 0.01,
      },
      {
        name: 'Glint_Angle',
        description: 'Glint angle (5 km resolution)',
        'gee:scale': 0.01,
      },
      {
        name: 'Fv',
        description: 'RTLS volumetric kernel (5 km resolution)',
      },
      {
        name: 'Fg',
        description: 'RTLS geometric kernel (5 km resolution)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface Bidirectional Reflectance Factor',
        lookat: {
          lat: 13,
          lon: 76,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'Sur_refl1'
              ],
            min: [
              0,
            ],
            max: [
              500,
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
    Sur_refl1: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl2: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl3: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl4: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl5: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl6: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl7: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl8: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl9: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl10: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl11: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sur_refl12: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sigma_BRFn1: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Sigma_BRFn2: {
      minimum: -100,
      maximum: 16000,
      'gee:estimated_range': false,
    },
    Status_QA: {
      minimum: 1,
      maximum: 65535,
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
    SAZ: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
    VAZ: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
    Glint_Angle: {
      minimum: -18000,
      maximum: 18000,
      'gee:estimated_range': false,
    },
    Fv: {
      minimum: -100,
      maximum: 100,
      'gee:estimated_range': false,
    },
    Fg: {
      minimum: -100,
      maximum: 100,
      'gee:estimated_range': false,
    },
  },
}
