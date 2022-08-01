{
  summaries: {
    gsd: [
      250.0,
    ],
    instruments: [
      'MODIS',
      'Shuttle Imaging Radar-C (SIR-C)',
    ],
    'eo:bands': [
      {
        name: 'water_mask',
        description: 'Land-water mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land-water mask',
              bit_count: 1,
              values: [
                {
                  description: 'Land',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Water',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'water_mask_QA',
        description: 'Quality assurance (QA)',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Quality assurance (QA)',
              bit_count: 4,
              values: [
                {
                  value: 1,
                  description: 'High confidence observation',
                },
                {
                  value: 2,
                  description: 'Lower confidence water, but MOD44W V5 is water',
                },
                {
                  value: 3,
                  description: 'Lower confidence land',
                },
                {
                  value: 4,
                  description: 'Ocean mask',
                },
                {
                  value: 5,
                  description: 'Ocean mask, but no water detected',
                },
                {
                  value: 6,
                  description: 'Burned area (MCD64A1)',
                },
                {
                  value: 7,
                  description: 'Urban or impervious surface',
                },
                {
                  value: 8,
                  description: 'No water detected, Version 5 MOD44W shows inland water',
                },
                {
                  value: 10,
                  description: 'No data (outside of projected area)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 4,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Mask',
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
              1.0,
            ],
            palette: [
              'bcba99',
              '2d0491',
            ],
            bands: [
              'water_mask',
            ],
          },
        },
      },
    ],
  },
}
