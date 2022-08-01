{
  summaries: {
    gsd: [
      500.0,
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
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band1',
        description: 'BRDF albedo mandatory quality for band 1',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band2',
        description: 'BRDF albedo mandatory quality for band 2',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band3',
        description: 'BRDF albedo mandatory quality for band 3',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band4',
        description: 'BRDF albedo mandatory quality for band 4',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band5',
        description: 'BRDF albedo mandatory quality for band 5',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band6',
        description: 'BRDF albedo mandatory quality for band 6',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_Band7',
        description: 'BRDF albedo mandatory quality for band 7',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_vis',
        description: 'BRDF albedo mandatory quality for visible broadband',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_nir',
        description: 'BRDF albedo mandatory quality for NIR broadband',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_shortwave',
        description: 'BRDF albedo mandatory quality for shortwave broadband',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA bit index',
              bit_count: 1,
              values: [
                {
                  description: 'Processed, good quality (full BRDF inversions)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Processed, see other QA (magnitude BRDF inversions)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
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
  },
}
