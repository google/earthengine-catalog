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
        name: 'Nadir_Reflectance_Band1',
        description: 'NBAR at local solar noon for band 1',
        center_wavelength: 0.645,
        'gee:scale': 0.0001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'Nadir_Reflectance_Band2',
        description: 'NBAR at local solar noon for band 2',
        center_wavelength: 0.8585,
        'gee:scale': 0.0001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'Nadir_Reflectance_Band3',
        description: 'NBAR at local solar noon for band 3',
        center_wavelength: 0.469,
        'gee:scale': 0.0001,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'Nadir_Reflectance_Band4',
        description: 'NBAR at local solar noon for band 4',
        center_wavelength: 0.555,
        'gee:scale': 0.0001,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'Nadir_Reflectance_Band5',
        description: 'NBAR at local solar noon for band 5',
        center_wavelength: 1.24,
        'gee:scale': 0.0001,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'Nadir_Reflectance_Band6',
        description: 'NBAR at local solar noon for band 6',
        center_wavelength: 1.64,
        'gee:scale': 0.0001,
        'gee:wavelength': '1628-1652nm',
      },
      {
        name: 'Nadir_Reflectance_Band7',
        description: 'NBAR at local solar noon for band 7',
        center_wavelength: 2.13,
        'gee:scale': 0.0001,
        'gee:wavelength': '2105-2155nm',
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
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            gamma: [
              1.5,
            ],
            bands: [
              'Nadir_Reflectance_Band1',
              'Nadir_Reflectance_Band4',
              'Nadir_Reflectance_Band3',
            ],
          },
        },
      },
    ],
    Nadir_Reflectance_Band1: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band2: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band3: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band4: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band5: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band6: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Nadir_Reflectance_Band7: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
  },
}
