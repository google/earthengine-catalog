{
  summaries: {
    gsd: [
      5600.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Albedo_BSA_Band1',
        description: 'Black-sky albedo for band 1',
        center_wavelength: 0.645,
        'gee:scale': 0.001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'Albedo_BSA_Band2',
        description: 'Black-sky albedo for band 2',
        center_wavelength: 0.8585,
        'gee:scale': 0.001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'Albedo_BSA_Band3',
        description: 'Black-sky albedo for band 3',
        center_wavelength: 0.469,
        'gee:scale': 0.001,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'Albedo_BSA_Band4',
        description: 'Black-sky albedo for band 4',
        center_wavelength: 0.555,
        'gee:scale': 0.001,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'Albedo_BSA_Band5',
        description: 'Black-sky albedo for band 5',
        center_wavelength: 1.24,
        'gee:scale': 0.001,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'Albedo_BSA_Band6',
        description: 'Black-sky albedo for band 6',
        center_wavelength: 1.64,
        'gee:scale': 0.001,
        'gee:wavelength': '1628-1652nm',
      },
      {
        name: 'Albedo_BSA_Band7',
        description: 'Black-sky albedo for band 7',
        center_wavelength: 2.13,
        'gee:scale': 0.001,
        'gee:wavelength': '2105-2155nm',
      },
      {
        name: 'Albedo_BSA_vis',
        description: 'Black-sky albedo for visible brodband',
        'gee:scale': 0.001,
      },
      {
        name: 'Albedo_BSA_nir',
        description: 'Black-sky albedo for NIR broadband',
        center_wavelength: 0.858,
        'gee:scale': 0.001,
        'gee:wavelength': '858nm',
      },
      {
        name: 'Albedo_BSA_shortwave',
        description: 'Black-sky albedo for shortwave broadband',
        'gee:scale': 0.001,
      },
      {
        name: 'Albedo_WSA_Band1',
        description: 'White-sky albedo for band 1',
        center_wavelength: 0.645,
        'gee:scale': 0.001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'Albedo_WSA_Band2',
        description: 'White-sky albedo for band 2',
        center_wavelength: 0.8585,
        'gee:scale': 0.001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'Albedo_WSA_Band3',
        description: 'White-sky albedo for band 3',
        center_wavelength: 0.469,
        'gee:scale': 0.001,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'Albedo_WSA_Band4',
        description: 'White-sky albedo for band 4',
        center_wavelength: 0.555,
        'gee:scale': 0.001,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'Albedo_WSA_Band5',
        description: 'White-sky albedo for band 5',
        center_wavelength: 1.24,
        'gee:scale': 0.001,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'Albedo_WSA_Band6',
        description: 'White-sky albedo for band 6',
        center_wavelength: 1.64,
        'gee:scale': 0.001,
        'gee:wavelength': '1628-1652nm',
      },
      {
        name: 'Albedo_WSA_Band7',
        description: 'White-sky albedo for band 7',
        center_wavelength: 2.13,
        'gee:scale': 0.001,
        'gee:wavelength': '2105-2155nm',
      },
      {
        name: 'Albedo_WSA_vis',
        description: 'White-sky albedo for visible broadband',
        'gee:scale': 0.001,
      },
      {
        name: 'Albedo_WSA_nir',
        description: 'White-sky albedo for NIR broadband',
        center_wavelength: 0.858,
        'gee:scale': 0.001,
        'gee:wavelength': '858nm',
      },
      {
        name: 'Albedo_WSA_shortwave',
        description: 'White-sky albedo for shortwave broadband',
        'gee:scale': 0.001,
      },
      {
        name: 'BRDF_Quality',
        description: 'Global albedo quality',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF and albedo quality information',
              bit_count: 3,
              values: [
                {
                  description: 'best quality, 100% with full inversions',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'good quality, 75% or more with best full inversions and 90% or more\nwith full inversions',
                },
                {
                  value: 2,
                  description: 'relative good quality, 75% or more with full inversions',
                },
                {
                  value: 3,
                  description: 'mixed, 75% or less full inversions and 25% or less fill values',
                },
                {
                  value: 4,
                  description: 'all magnitude inversions or 50% or less fill values',
                },
                {
                  value: 5,
                  description: 'all magnitude inversions or 50% or less fill values',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'Local_Solar_Noon',
        description: 'Local solar noon zenith angle',
        'gee:units': 'degrees',
      },
      {
        name: 'Percent_Inputs',
        description: 'Percent of the processed finer resolution data which contributed to this CMG pixel',
        'gee:units': '%',
      },
      {
        name: 'Percent_Snow',
        description: 'Percent of underlying data flagged as snow',
        'gee:units': '%',
      },
      {
        name: 'BRDF_Albedo_Uncertainty',
        description: |||
          BRDF inversion information. Weights of determination (WoD) of the white
          sky albedo (see Lucht, W., & Lewis, P. (2000). Theoretical noise
          sensitivity of BRDF and albedo retrieval from the EOS-MODIS and MISR
          sensors with respect to angular sampling. International Journal of
          Remote Sensing, 21(1), 81-98). WoDs give a measure of the
          uncertainty due to the angular sampling of the inputs available for each
          retrieval.
        |||,
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Black-Sky Albedo',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              400.0,
            ],
            bands: [
              'Albedo_BSA_Band1',
            ],
          },
        },
      },
    ],
    Albedo_BSA_Band1: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band2: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band3: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band4: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band5: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band6: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_Band7: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_vis: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_nir: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_BSA_shortwave: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band1: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band2: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band3: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band4: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band5: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band6: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_Band7: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_vis: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_nir: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Albedo_WSA_shortwave: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Local_Solar_Noon: {
      minimum: 0.0,
      maximum: 90.0,
      'gee:estimated_range': false,
    },
    Percent_Inputs: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Percent_Snow: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    BRDF_Albedo_Uncertainty: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
  },
}
