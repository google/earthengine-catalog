local units = import 'units.libsonnet';

{
  bands: [
    {
      name: 'Count_Day',
      description: 'Count of Daytime Input Values',
    },
    {
      name: 'Count_Night',
      description: 'Count of Nighttime Input Values',
    },
    {
      name: 'QC_Day',
      description: 'Quality Control for Daytime LST and Emissivity',
      'gee:bitmask': {
        bitmask_parts: [
          {
            description: 'Mandatory QA flags',
            bit_count: 2,
            values: [
              {
                description: 'Pixel produced, good quality, no further QA info necessary',
                value: 0,
              },
              {
                value: 1,
                description: 'Pixel produced, nominal quality. Recommend more detailed analysis of other QC information',
              },
              {
                value: 2,
                description: 'Pixel not produced due to cloud',
              },
              {
                value: 3,
                description: 'Pixel not produced due to reasons other than cloud',
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
                description: 'Good data quality of L1B bands 29, 31, 32',
                value: 0,
              },
              {
                value: 1,
                description: 'Missing pixel',
              },
              {
                value: 2,
                description: 'Fairly calibrated',
              },
              {
                value: 3,
                description: 'Poorly calibrated, TES processing skipped',
              },
            ],
          },
          {
            description: 'Emissivity accuracy',
            first_bit: 4,
            bit_count: 2,
            values: [
              {
                description: '>0.02 (Poor performance)',
                value: 0,
              },
              {
                value: 1,
                description: '0.015 - 0.02 (Marginal performance)',
              },
              {
                value: 2,
                description: '0.01 - 0.015 (Good performance)',
              },
              {
                value: 3,
                description: '<0.01 (Excellent performance)',
              },
            ],
          },
          {
            description: 'LST accuracy',
            first_bit: 6,
            bit_count: 2,
            values: [
              {
                description: '>2K (Poor performance)',
                value: 0,
              },
              {
                value: 1,
                description: '1.5 - 2K (Marginal performance)',
              },
              {
                value: 2,
                description: '1 - 1.5K (Good performance)',
              },
              {
                value: 3,
                description: '<1K (Excellent performance)',
              },
            ],
          },
        ],
        total_bit_count: 8,
      },
    },
    {
      name: 'QC_Night',
      description: 'Quality Control for Nighttime LST and Emissivity',
      'gee:bitmask': {
        bitmask_parts: [
          {
            description: 'Mandatory QA flags',
            bit_count: 2,
            values: [
              {
                description: 'Pixel produced, good quality, no further QA info necessary',
                value: 0,
              },
              {
                value: 1,
                description: 'Pixel produced, nominal quality. Recommend more detailed analysis of other QC information',
              },
              {
                value: 2,
                description: 'Pixel not produced due to cloud',
              },
              {
                value: 3,
                description: 'Pixel not produced due to reasons other than cloud',
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
                description: 'Good data quality of L1B bands 29, 31, 32',
                value: 0,
              },
              {
                value: 1,
                description: 'Missing pixel',
              },
              {
                value: 2,
                description: 'Fairly calibrated',
              },
              {
                value: 3,
                description: 'Poorly calibrated, TES processing skipped',
              },
            ],
          },
          {
            description: 'Emissivity accuracy',
            first_bit: 4,
            bit_count: 2,
            values: [
              {
                description: '>0.02 (Poor performance)',
                value: 0,
              },
              {
                value: 1,
                description: '0.015 - 0.02 (Marginal performance)',
              },
              {
                value: 2,
                description: '0.01 - 0.015 (Good performance)',
              },
              {
                value: 3,
                description: '<0.01 (Excellent performance)',
              },
            ],
          },
          {
            description: 'LST accuracy',
            first_bit: 6,
            bit_count: 2,
            values: [
              {
                description: '>2K (Poor performance)',
                value: 0,
              },
              {
                value: 1,
                description: '1.5 - 2K (Marginal performance)',
              },
              {
                value: 2,
                description: '1 - 1.5K (Good performance)',
              },
              {
                value: 3,
                description: '<1K (Excellent performance)',
              },
            ],
          },
        ],
        total_bit_count: 8,
      },
    },
    {
      name: 'LST_Day',
      description: 'Average Daytime Land Surface Temperature',
      'gee:units': units.kelvin,
      'gee:scale': 0.02,
    },
    {
      name: 'LST_Night',
      description: 'Average Nighttime Land Surface Temperature',
      'gee:units': units.kelvin,
      'gee:scale': 0.02,
    },
    {
      name: 'LST_Day_err',
      description: 'Root-mean-square-error Daytime Land Surface Temperature',
      'gee:units': units.kelvin,
      'gee:scale': 0.04,
    },
    {
      name: 'LST_Night_err',
      description: 'Average Nighttime Land Surface Temperature',
      'gee:units': units.kelvin,
      'gee:scale': 0.04,
    },
    {
      name: 'Day_view_angle',
      description: 'Average Daytime View Zenith Angle',
      'gee:units': 'degrees',
      'gee:offset': -65.0,
    },
    {
      name: 'Night_view_angle',
      description: 'Average Nighttime View Zenith Angle',
      'gee:units': 'degrees',
      'gee:offset': -65.0,
    },
    {
      name: 'Day_view_time',
      description: 'Average Daytime View Time (UTC)',
      'gee:units': units.hour,
      'gee:scale': 0.2,
    },
    {
      name: 'Night_view_time',
      description: 'Average Nighttime View Time (UTC)',
      'gee:units': units.hour,
      'gee:scale': 0.2,
    },
    {
      name: 'Emis_29_Day',
      description: 'Average Daytime Band 29 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_29_Night',
      description: 'Average Nighttime Band 29 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_29_Day_err',
      description: 'Root-mean-square-error Daytime Band 29 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'Emis_29_Night_err',
      description: 'Root-mean-square-error Nighttime Band 29 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'Emis_31_Day',
      description: 'Average Daytime Band 31 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_31_Night',
      description: 'Average Nighttime Band 31 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_31_Day_err',
      description: 'Root-mean-square-error Daytime Band 31 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'Emis_31_Night_err',
      description: 'Root-mean-square-error Nighttime Band 31 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'Emis_32_Day',
      description: 'Average Daytime Band 32 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_32_Night',
      description: 'Average Nighttime Band 32 Emissivity',
      'gee:scale': 0.002,
      'gee:offset': 0.49,
    },
    {
      name: 'Emis_32_Day_err',
      description: 'Root-mean-square-error Daytime Band 32 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'Emis_32_Night_err',
      description: 'Root-mean-square-error Nighttime Band 32 Emissivity',
      'gee:scale': 0.0001,
    },
    {
      name: 'View_Angle',
      description: 'MODIS view zenith angle',
      'gee:units': 'degrees',
      'gee:offset': -65.0,
    },
    {
      name: 'Percent_land_in_grid',
      description: 'Percent of Land Detections in Grid Cell',
      'gee:units': units.percent,
    },
  ],
  summaries: {
    gsd: [
      1000.0,
    ],
    instruments: [
      'MODIS',
    ],
    'gee:visualizations': [
      {
        display_name: 'Average Daytime Land Surface Temperature',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              216.0,
            ],
            max: [
              348.0,
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
              'LST_Day',
            ],
          },
        },
      },
    ],
    Count_Day: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Count_Night: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    QC_Day: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    QC_Night: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    LST_Day: {
      minimum: 7500.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    LST_Night: {
      minimum: 7500.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    LST_Day_err: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    LST_Night_err: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Day_view_angle: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    Night_view_angle: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    Day_view_time: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': false,
    },
    Night_view_time: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': false,
    },
    Emis_29_Day: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_29_Night: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_29_Day_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_29_Night_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_31_Day: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_31_Night: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_31_Day_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_31_Night_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_32_Day: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_32_Night: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Emis_32_Day_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_32_Night_err: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Percent_land_in_grid: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
