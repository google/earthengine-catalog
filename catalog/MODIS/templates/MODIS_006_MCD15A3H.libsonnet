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
        name: 'Fpar',
        description: 'FPAR absorbed by the green elements of a vegetation canopy',
        center_wavelength: 0.55,
        'gee:scale': 0.01,
        'gee:wavelength': '400-700nm',
      },
      {
        name: 'Lai',
        description: |||
          One-sided green leaf area per unit ground area in
          broadleaf canopies; one-half the total needle surface area per
          unit ground area in coniferous canopies
        |||,
        'gee:scale': 0.1,
      },
      {
        name: 'FparLai_QC',
        description: 'Quality for Lai and Fpar',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND_QC bits',
              bit_count: 1,
              values: [
                {
                  description: 'Good quality (main algorithm with or without saturation)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality (back-up algorithm or fill values)',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Sensor',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Terra',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Aqua',
                },
              ],
            },
            {
              description: 'Dead detector',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Detectors apparently fine for up to 50% of channels 1, 2',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Dead detectors caused >50% adjacent detector retrieval',
                },
              ],
            },
            {
              description: 'Cloud state',
              first_bit: 3,
              bit_count: 2,
              values: [
                {
                  description: 'Significant clouds NOT present (clear)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Significant clouds WERE present',
                },
                {
                  value: 2,
                  description: 'Mixed cloud present in pixel',
                },
                {
                  value: 3,
                  description: 'Cloud state not defined, assumed clear',
                },
              ],
            },
            {
              description: 'SCF_QC',
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'Main (RT) method used with no saturation, best result possible',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Main (RT) method used with saturation, good and very usable',
                },
                {
                  value: 2,
                  description: 'Main (RT) method failed due to bad geometry, empirical algorithm used',
                },
                {
                  value: 3,
                  description: 'Main (RT) method failed due to problems other\nthan geometry, empirical algorithm used',
                },
                {
                  value: 4,
                  description: |||
                    Pixel not produced at all, value couldn''t
                    be retrieved (possible reasons: bad L1B data, unusable
                    MOD09GA data)
                  |||,
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'FparExtra_QC',
        description: 'Extra detail quality for LAI and FPAR',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land-sea pass−thru',
              bit_count: 2,
              values: [
                {
                  description: 'LAND',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'SHORE',
                },
                {
                  value: 2,
                  description: 'FRESHWATER',
                },
                {
                  value: 3,
                  description: 'OCEAN',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Snow ice',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'No snow/ice detected',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow/ice detected',
                },
              ],
            },
            {
              description: 'Aerosol',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'No or low atmospheric aerosol levels detected',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Average or high aerosol levels detected',
                },
              ],
            },
            {
              description: 'Cirrus',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'No cirrus detected',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cirrus detected',
                },
              ],
            },
            {
              description: 'Internal cloud mask',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No clouds',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Clouds were detected',
                },
              ],
            },
            {
              description: 'Cloud shadow',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'No cloud shadow detected',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud shadow detected',
                },
              ],
            },
            {
              description: 'SCF biome mask',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Biome outside interval <1,4>',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Biome in interval <1,4>',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'FparStdDev',
        description: 'Standard deviation of Fpar',
        'gee:scale': 0.01,
      },
      {
        name: 'LaiStdDev',
        description: 'Standard deviation for Lai',
        'gee:scale': 0.1,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Default visualization',
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
              100.0,
            ],
            palette: [
              'e1e4b4',
              '999d60',
              '2ec409',
              '0a4b06',
            ],
            bands: [
              'Fpar',
            ],
          },
        },
      },
    ],
    Fpar: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Lai: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    FparStdDev: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    LaiStdDev: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
