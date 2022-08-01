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
        name: 'Npp',
        description: 'Net primary productivity',
        'gee:units': 'kg*C/m^2',
        'gee:scale': 0.0001,
      },
      {
        name: 'Npp_QC',
        description: 'Quality control bits',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QC bits',
              bit_count: 1,
              values: [
                {
                  description: 'Good quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality',
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
                  description: 'Mixed cloud present on pixel',
                },
                {
                  value: 3,
                  description: 'Cloud state not defined, assumed clear',
                },
              ],
            },
            {
              description: '5-level confidence quality score',
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'Very best possible',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good, very usable, but not the best',
                },
                {
                  value: 2,
                  description: 'Substandard due to geometry problems - use with caution',
                },
                {
                  value: 3,
                  description: 'Substandard due to other than geometry problems - use with caution',
                },
                {
                  value: 4,
                  description: "Couldn't retrieve pixel (NOT PRODUCED AT ALL - non-terrestrial biome)",
                },
                {
                  value: 7,
                  description: 'Fill Value',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NPP',
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
              19000.0,
            ],
            palette: [
              'bbe029',
              '0a9501',
              '074b03',
            ],
            bands: [
              'Npp',
            ],
          },
        },
      },
    ],
    Npp: {
      minimum: -3000.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
  },
}
