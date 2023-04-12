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
        name: 'LST_Day_1km',
        description: 'Daytime Land Surface Temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'QC_Day',
        description: 'Daytime LST Quality Indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA flags',
              bit_count: 2,
              values: [
                {
                  description: 'LST produced, good quality, not necessary to examine more detailed QA',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'LST produced, other quality, recommend examination of more detailed QA',
                },
                {
                  value: 2,
                  description: 'LST not produced due to cloud effects',
                },
                {
                  value: 3,
                  description: 'LST not produced primarily due to reasons other than cloud',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Data quality flag',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Good data quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality data',
                },
                {
                  value: 2,
                  description: 'TBD',
                },
                {
                  value: 3,
                  description: 'TBD',
                },
              ],
            },
            {
              description: 'Emissivity error flag',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Average emissivity error <= 0.01',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Average emissivity error <= 0.02',
                },
                {
                  value: 2,
                  description: 'Average emissivity error <= 0.04',
                },
                {
                  value: 3,
                  description: 'Average emissivity error > 0.04',
                },
              ],
            },
            {
              description: 'LST error flag',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Average LST error <= 1K',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Average LST error <= 2K',
                },
                {
                  value: 2,
                  description: 'Average LST error <= 3K',
                },
                {
                  value: 3,
                  description: 'Average LST error > 3K',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Day_view_time',
        description: 'Local time of day observation',
        'gee:units': units.hour,
        'gee:scale': 0.1,
      },
      {
        name: 'Day_view_angle',
        description: 'View zenith angle of day observation',
        'gee:units': units.degree,
        'gee:offset': -65.0,
      },
      {
        name: 'LST_Night_1km',
        description: 'Nighttime Land Surface Temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'QC_Night',
        description: 'Nighttime LST Quality indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA flags',
              bit_count: 2,
              values: [
                {
                  description: 'LST produced, good quality, not necessary to examine more detailed QA',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'LST produced, other quality, recommend examination of more detailed QA',
                },
                {
                  value: 2,
                  description: 'LST not produced due to cloud effects',
                },
                {
                  value: 3,
                  description: 'LST not produced primarily due to reasons other than cloud',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Data quality flag',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Good data quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality data',
                },
                {
                  value: 2,
                  description: 'TBD',
                },
                {
                  value: 3,
                  description: 'TBD',
                },
              ],
            },
            {
              description: 'Emissivity error flag',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Average emissivity error <= 0.01',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Average emissivity error <= 0.02',
                },
                {
                  value: 2,
                  description: 'Average emissivity error <= 0.04',
                },
                {
                  value: 3,
                  description: 'Average emissivity error > 0.04',
                },
              ],
            },
            {
              description: 'LST error flag',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Average LST error <= 1K',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Average LST error <= 2K',
                },
                {
                  value: 2,
                  description: 'Average LST error <= 3K',
                },
                {
                  value: 3,
                  description: 'Average LST error > 3K',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Night_view_time',
        description: 'Local time of night observation',
        'gee:units': units.hour,
        'gee:scale': 0.1,
      },
      {
        name: 'Night_view_angle',
        description: 'View zenith angle of night observation',
        'gee:units': units.degree,
        'gee:offset': -65.0,
      },
      {
        name: 'Emis_31',
        description: 'Band 31 emissivity',
        'gee:scale': 0.002,
        'gee:offset': 0.49,
      },
      {
        name: 'Emis_32',
        description: 'Band 32 emissivity',
        'gee:scale': 0.002,
        'gee:offset': 0.49,
      },
      {
        name: 'Clear_day_cov',
        description: 'Day clear-sky coverage',
        'gee:scale': 0.0005,
      },
      {
        name: 'Clear_night_cov',
        description: 'Night clear-sky coverage',
        'gee:scale': 0.0005,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Surface Temperature',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              13000.0,
            ],
            max: [
              16500.0,
            ],
            gain: [
              0.1,
            ],
            bias: [
              -1400.0,
            ],
            palette: [
              '040274',
              '040281',
              '0502a3',
              '0502b8',
              '0502ce',
              '0502e6',
              '0602ff',
              '235cb1',
              '307ef3',
              '269db1',
              '30c8e2',
              '32d3ef',
              '3be285',
              '3ff38f',
              '86e26f',
              '3ae237',
              'b5e22e',
              'd6e21f',
              'fff705',
              'ffd611',
              'ffb613',
              'ff8b13',
              'ff6e08',
              'ff500d',
              'ff0000',
              'de0101',
              'c21301',
              'a71001',
              '911003',
            ],
            bands: [
              'LST_Day_1km',
            ],
          },
        },
      },
    ],
    LST_Day_1km: {
      minimum: 7500.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Day_view_time: {
      minimum: 0.0,
      maximum: 240.0,
      'gee:estimated_range': false,
    },
    Day_view_angle: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    LST_Night_1km: {
      minimum: 7500.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Night_view_time: {
      minimum: 0.0,
      maximum: 240.0,
      'gee:estimated_range': false,
    },
    Night_view_angle: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    Emis_31: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_32: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Clear_day_cov: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Clear_night_cov: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
  },
}
