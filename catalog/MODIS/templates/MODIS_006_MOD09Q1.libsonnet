{
  summaries: {
    gsd: [
      250.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'sur_refl_b01',
        description: 'Surface reflectance band 1',
        center_wavelength: 0.645,
        'gee:scale': 0.0001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'sur_refl_b02',
        description: 'Surface reflectance for band 2',
        center_wavelength: 0.8585,
        'gee:scale': 0.0001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'State',
        description: 'Surface reflectance 250m state flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud state',
              bit_count: 2,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
                {
                  value: 2,
                  description: 'Mixed',
                },
                {
                  value: 3,
                  description: 'Not set, assumed clear',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud shadow',
              first_bit: 2,
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
              description: 'Land/water flag',
              first_bit: 3,
              bit_count: 3,
              values: [
                {
                  description: 'Shallow ocean',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land',
                },
                {
                  value: 2,
                  description: 'Ocean coastlines and lake shorelines',
                },
                {
                  value: 3,
                  description: 'Shallow inland water',
                },
                {
                  value: 4,
                  description: 'Ephemeral water',
                },
                {
                  value: 5,
                  description: 'Deep inland water',
                },
                {
                  value: 6,
                  description: 'Continental/moderate ocean',
                },
                {
                  value: 7,
                  description: 'Deep ocean',
                },
              ],
            },
            {
              description: 'Aerosol quantity',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Average',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cirrus detected',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Small',
                },
                {
                  value: 2,
                  description: 'Average',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Internal cloud algorithm flag',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No cloud',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud',
                },
              ],
            },
            {
              description: 'Internal fire algorithm flag',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'No fire',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Fire',
                },
              ],
            },
            {
              description: 'MOD35 snow/ice flag',
              first_bit: 12,
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
              description: 'Pixel is adjacent to cloud',
              first_bit: 13,
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
              description: 'BRDF correction performed data',
              first_bit: 14,
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
              description: 'Internal snow mask',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'No snow',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'QA',
        description: 'Surface reflectance 250m band quality control flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QA bits',
              bit_count: 2,
              values: [
                {
                  description: 'Corrected product produced at ideal quality - all bands',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Corrected product produced at less than ideal quality - some or all bands',
                },
                {
                  value: 2,
                  description: 'Corrected product not produced due to cloud effects - all bands',
                },
                {
                  value: 3,
                  description: |||
                    Corrected product not produced for other reasons
                    - some or all bands, may be fill value (11) [Note that
                    a value of (11) overrides a value of (01)]
                  |||,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Spare (unused)',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
            {
              description: 'Band 1 data quality',
              first_bit: 4,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: 'Internal constant used in place of climatological\ndata for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Band 2 data quality',
              first_bit: 8,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: 'Internal constant used in place of climatological\ndata for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Atmospheric correction performed',
              first_bit: 12,
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
              description: 'Adjacency correction performed',
              first_bit: 13,
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
              description: 'Different orbit from 500m',
              first_bit: 14,
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
              description: 'Spare (unused)',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              6000.0,
            ],
            bands: [
              'sur_refl_b02',
              'sur_refl_b02',
              'sur_refl_b01',
            ],
          },
        },
      },
    ],
    sur_refl_b01: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b02: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
  },
}
