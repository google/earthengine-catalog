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
        name: 'LST_1KM',
        description: 'Land Surface Temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'QC',
        description: 'Quality Control',
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
                  description: 'Pixel produced, nominal quality.',
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
              description: 'Cloud Flag',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Cloud free',
                  value: 0,
                },
                {
                  value: 1,
                  description: ' Thin cirrus',
                },
                {
                  value: 2,
                  description: 'Pixel within 2 pixels of nearest cloud',
                },
                {
                  value: 3,
                  description: 'Cloudy pixel',
                },
              ],
            },
            {
              description: 'TES Iterations',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: '>=7 (Slow convergence)',
                  value: 0,
                },
                {
                  value: 1,
                  description: '6 (Nominal)',
                },
                {
                  value: 2,
                  description: '5 (Nominal)',
                },
                {
                  value: 3,
                  description: '<5 (Fast)',
                },
              ],
            },
            {
              description: 'Atmospheric Opacity',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: '>=3 (Warm, humid air; or cold land)',
                  value: 0,
                },
                {
                  value: 1,
                  description: '0.2 - 0.3 (Nominal value)',
                },
                {
                  value: 2,
                  description: '0.1 - 0.2 (Nominal value)',
                },
                {
                  value: 3,
                  description: '<0.1 (Dry, or high altitude pixel)',
                },
              ],
            },
            {
              description: 'Min-Max Difference(MMD). Difference between minimum and maximum emissivity for bands 29, 31, 32',
              first_bit: 10,
              bit_count: 2,
              values: [
                {
                  description: '0.15 (Most silicate rocks)',
                  value: 0,
                },
                {
                  value: 1,
                  description: '0.1 - 0.15 (Rocks, sand, some soils)',
                },
                {
                  value: 2,
                  description: '0.03 - 0.1 (Mostly soils, mixed pixel)',
                },
                {
                  value: 3,
                  description: '<0.03 (Vegetation, snow, water, ice)',
                },
              ],
            },
            {
              description: 'Emissivity accuracy',
              first_bit: 12,
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
              first_bit: 14,
              bit_count: 2,
              values: [
                {
                  description: '>2 K (Poor performance)',
                  value: 0,
                },
                {
                  value: 1,
                  description: '1.5 - 2 K (Marginal performance)',
                },
                {
                  value: 2,
                  description: '1 - 1.5 K (Good performance)',
                },
                {
                  value: 3,
                  description: '<1 K (Excellent performance)',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'Emis_29',
        description: 'Band 29 emissivity',
        'gee:scale': 0.002,
        'gee:offset': 0.49,
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
        name: 'View_Angle',
        description: 'MODIS view zenith angle',
        'gee:units': units.degree,
        'gee:offset': -65.0,
      },
      {
        name: 'View_Time',
        description: 'Time of MODIS observation',
        'gee:units': units.hour,
        'gee:scale': 0.1,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Surface Temperature',
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
              'LST_1KM',
            ],
          },
        },
      },
    ],
    LST_1KM: {
      minimum: 7500.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    QC: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Emis_29: {
      minimum: 0.0,
      maximum: 255.0,
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
    View_Angle: {
      minimum: 0.0,
      maximum: 130.0,
      'gee:estimated_range': false,
    },
    View_Time: {
      minimum: 0.0,
      maximum: 240.0,
      'gee:estimated_range': false,
    },
  },
}
