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
        name: 'ET',
        description: 'Total evapotranspiration',
        'gee:units': 'kg/m^2/8day',
        'gee:scale': 0.1,
      },
      {
        name: 'LE',
        description: 'Average latent heat flux',
        'gee:units': 'J/m^2/day',
        'gee:scale': 10000.0,
      },
      {
        name: 'PET',
        description: 'Total potential evapotranspiration',
        'gee:units': 'kg/m^2/8day',
        'gee:scale': 0.1,
      },
      {
        name: 'PLE',
        description: 'Average potential latent heat flux',
        'gee:units': 'J/m^2/day',
        'gee:scale': 10000.0,
      },
      {
        name: 'ET_QC',
        description: 'Evapotranspiration quality control flags',
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
                  description: 'Mixed cloud present on pixel',
                },
                {
                  value: 3,
                  description: 'Cloud state not defined, assumed clear',
                },
              ],
            },
            {
              description: 'SCF_QC 5-level confidence quality score',
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'Main (RT) method used, best result possible (no saturation)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Main (RT) method used with saturation. Good, very usable',
                },
                {
                  value: 2,
                  description: 'Main (RT) method failed due to bad geometry, empirical algorithm used',
                },
                {
                  value: 3,
                  description: 'Main (RT) method failed due to problems other than geometry, empirical algorithm used',
                },
                {
                  value: 4,
                  description: |||
                    Pixel not produced at all, value couldn't be
                    retrieved (possible reasons: bad L1B data, unusable MOD09GA data)
                  |||,
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
        display_name: 'Evapotranspiration',
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
              300.0,
            ],
            palette: [
              'ffffff',
              'fcd163',
              '99b718',
              '66a000',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '011301',
            ],
            bands: [
              'ET',
            ],
          },
        },
      },
    ],
    ET: {
      minimum: -32767.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
    LE: {
      minimum: -32767.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
    PET: {
      minimum: -32767.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
    PLE: {
      minimum: -32767.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
  },
}
