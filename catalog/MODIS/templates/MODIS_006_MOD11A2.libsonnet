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
        description: 'Day land surface temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'QC_Day',
        description: 'Daytime LST quality indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA flags',
              bit_count: 2,
              values: [
                {
                  description: 'Pixel produced, good quality, not necessary to examine more detailed QA',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel produced, unreliable or unquantifiable quality, recommend examination of more detailed QA',
                },
                {
                  value: 2,
                  description: 'Pixel not produced due to cloud effects',
                },
                {
                  value: 3,
                  description: 'Pixel not produced primarily due to reasons other than cloud (such as ocean pixel, poor input data)',
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
        name: 'Day_view_angl',
        description: 'View zenith angle of day observation',
        'gee:units': 'Degrees',
        'gee:offset': -65.0,
      },
      {
        name: 'LST_Night_1km',
        description: 'Night land surface temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'QC_Night',
        description: 'Nighttime LST quality indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA flags',
              bit_count: 2,
              values: [
                {
                  description: 'Pixel produced, good quality, not necessary to examine more detailed QA',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel produced, unreliable or unquantifiable quality, recommend examination of more detailed QA',
                },
                {
                  value: 2,
                  description: 'Pixel not produced due to cloud effects',
                },
                {
                  value: 3,
                  description: 'Pixel not produced primarily due to reasons other than cloud (such as ocean pixel, poor input data)',
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
        name: 'Night_view_angl',
        description: 'View zenith angle of night observation',
        'gee:units': 'Degrees',
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
        name: 'Clear_sky_days',
        description: 'Days in clear-sky conditions',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Day 1 clear sky flag',
              bit_count: 1,
              values: [
                {
                  description: 'Day 1 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 1 is clear-sky',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Day 2 clear sky flag',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Day 2 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 2 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 3 clear sky flag',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Day 3 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 3 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 4 clear sky flag',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Day 4 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 4 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 5 clear sky flag',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Day 5 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 5 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 6 clear sky flag',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Day 6 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 6 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 7 clear sky flag',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Day 7 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 7 is clear-sky',
                },
              ],
            },
            {
              description: 'Day 8 clear sky flag',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Day 8 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day 8 is clear-sky',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Clear_sky_nights',
        description: 'Nights in clear-sky conditions',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Night 1 clear sky flag',
              bit_count: 1,
              values: [
                {
                  description: 'Night 1 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 1 is clear-sky',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Night 2 clear sky flag',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Night 2 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 2 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 3 clear sky flag',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Night 3 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 3 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 4 clear sky flag',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Night 4 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 4 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 5 clear sky flag',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Night 5 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 5 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 6 clear sky flag',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Night 6 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 6 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 7 clear sky flag',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Night 7 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 7 is clear-sky',
                },
              ],
            },
            {
              description: 'Night 8 clear sky flag',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Night 8 is not clear-sky',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night 8 is clear-sky',
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
        display_name: 'Land Surface Temperature',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              14000.0,
            ],
            max: [
              16000.0,
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
    Day_view_angl: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    LST_Night_1km: {
      minimum: 7500.0,
      maximum: 65635.0,
      'gee:estimated_range': false,
    },
    Night_view_time: {
      minimum: 0.0,
      maximum: 240.0,
      'gee:estimated_range': false,
    },
    Night_view_angl: {
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
  },
}
