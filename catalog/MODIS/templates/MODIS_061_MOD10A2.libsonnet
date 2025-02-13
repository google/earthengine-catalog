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
        name: 'Maximum_Snow_Extent',
        description: |||
          Maximum snow extent observed over an eight-day period.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'Missing data',
          },
          {
            value: 1,
            description: 'No decision',
          },
          {
            value: 11,
            description: 'Night',
          },
          {
            value: 25,
            description: 'No snow',
          },
          {
            value: 37,
            description: 'Lake',
          },
          {
            value: 39,
            description: 'Ocean',
          },
          {
            value: 50,
            description: 'Cloud',
          },
          {
            value: 100,
            description: 'Lake ice',
          },
          {
            value: 200,
            description: 'Snow',
          },
          {
            value: 254,
            description: 'Detector saturated',
          },
        ],
      },
      {
        name: 'Eight_Day_Snow_Cover',
        description: |||
          Snow chronology bit flags for each day in the eight-day
          observation period.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'day 1',
              bit_count: 1,
              first_bit: 0,
            },
            {
              description: 'day 2',
              first_bit: 1,
              bit_count: 1,
            },
            {
              description: 'day 3',
              first_bit: 2,
              bit_count: 1,
            },
            {
              description: 'day 4',
              first_bit: 3,
              bit_count: 1,
            },
            {
              description: 'day 5',
              first_bit: 4,
              bit_count: 1,
            },
            {
              description: 'day 6',
              first_bit: 5,
              bit_count: 1,
            },
            {
              description: 'day 7',
              first_bit: 6,
              bit_count: 1,
            },
            {
              description: 'day 8',
              first_bit: 7,
              bit_count: 1,
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Maximum Snow Extent',
        lookat: {
          lat: 65.99,
          lon: -3.69,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              50.0,
            ],
            max: [
              150.0,
            ],
            palette: [
              '000000',
              '0dffff',
              '0524ff',
              'ffffff',
            ],
            bands: [
              'Maximum_Snow_Extent',
            ],
          },
        },
      },
    ],
    Maximum_Snow_Extent: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
}
