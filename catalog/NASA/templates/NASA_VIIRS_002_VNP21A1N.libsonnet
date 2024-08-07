local units = import 'units.libsonnet';

{
  summaries: {
    gsd: [
      1000.0,
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'LST_1KM',
        description: |||
          Daily 1 km Land Surface Temperature.
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'QC',
        description: 'Daily Quality control for LST and emissivity',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA flags',
              bit_count: 2,
              values: [
                {
                  description: |||
                   Pixel produced, good quality, no further QA info necessary
                  |||,
                  value: 0,
                },
                {
                  description: 'Pixel produced but unreliable quality',
                  value: 1,
                },
                {
                  description: 'Pixel not produced due to cloud',
                  value: 2,
                },
                {
                  description: |||
                    Pixel not produced due to reasons other than cloud
                  |||,
                  value: 3,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Data quality flag',
              bit_count: 2,
              values: [
                {
                  description: 'Good data quality of L1B bands 14, 15, 16',
                  value: 0,
                },
                {
                  description: 'Missing pixel',
                  value: 1,
                },
                {
                  description: 'Fairly calibrated',
                  value: 2,
                },
                {
                  description: 'Poorly calibrated, TES processing skipped',
                  value: 3,
                },
              ],
              first_bit: 2,
            },
            {
              description: 'Cloud Flag',
              bit_count: 2,
              values: [
                {
                  description: 'Cloud-free',
                  value: 0,
                },
                {
                  description: 'Thin cirrus',
                  value: 1,
                },
                {
                  description: 'Pixel within 2 pixels of nearest cloud',
                  value: 2,
                },
                {
                  description: 'Cloudy pixels',
                  value: 3,
                },
              ],
              first_bit: 4,
            },
            {
              description: 'Iterations',
              bit_count: 2,
              values: [
                {
                  description: ' Slow convergence',
                  value: 0,
                },
                {
                  description: 'Nominal',
                  value: 1,
                },
                {
                  description: 'Nominal',
                  value: 2,
                },
                {
                  description: 'Fast',
                  value: 3,
                },
              ],
              first_bit: 6,
            },
            {
              description: 'Atmospheric Opacity',
              bit_count: 2,
              values: [
                {
                  description: '&ge;3 (Warm, humid air; or cold land)',
                  value: 0,
                },
                {
                  description: '0.2 - 0.3 (Nominal value)',
                  value: 1,
                },
                {
                  description: '0.1 - 0.2 (Nominal value)',
                  value: 2,
                },
                {
                  description: '<0.1 (Dry, or high altitude pixel)',
                  value: 3,
                },
              ],
              first_bit: 8,
            },
            {
              description: 'MMD',
              bit_count: 2,
              values: [
                {
                  description: '&gt;0.15 (Most silicate rocks)',
                  value: 0,
                },
                {
                  description: '0.1 - 0.15 (Rocks, sand, some soils)',
                  value: 1,
                },
                {
                  description: '0.03 - 0.1 (Mostly soils, mixed pixel)',
                  value: 2,
                },
                {
                  description: |||
                    <0.03 (Vegetation, snow, water, ice, some soils)
                  |||,
                  value: 3,
                },
              ],
              first_bit: 10,
            },
            {
              description: 'Emissivity accuracy',
              bit_count: 2,
              values: [
                {
                  description: '&gt;0.02 (Poor performance)',
                  value: 0,
                },
                {
                  description: '0.015 - 0.02 (Marginal performance)',
                  value: 1,
                },
                {
                  description: '0.01 - 0.015 (Good performance)',
                  value: 2,
                },
                {
                  description: '<0.01 (Excellent performance)',
                  value: 3,
                },
              ],
              first_bit: 12,
            },
            {
              description: 'LST accuracy',
              bit_count: 2,
              values: [
                {
                  description: '&gt;2K (Poor performance)',
                  value: 0,
                },
                {
                  description: '1.5 - 2K (Marginal performance)',
                  value: 1,
                },
                {
                  description: '1 - 1.5K (Good performance)',
                  value: 2,
                },
                {
                  description: '<1K (Excellent performance)',
                  value: 3,
                },
              ],
              first_bit: 14,
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'Emis_14',
        description: 'Daily M14 emissivity',
      },
      {
        name: 'Emis_15',
        description: 'Daily M15 emissivity',
      },
      {
        name: 'Emis_16',
        description: 'Daily M16 emissivity',
      },
      {
        name: 'View_Angle',
        description: 'View zenith angle of LST',
        'gee:units': units.degree,
      },
      {
        name: 'View_Time',
        description: 'Time of LST observation',
        'gee:units': units.hour,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Daily emissivity',
        lookat: {
          lat: 41.2,
          lon: 38.84,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'LST_1KM',
            ],
            min:[
              200,
            ],
            max:[
              300,
            ],
            palette: [
            'a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf',
            'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837'
            ]
          },
        },
      },
    ],
  }
}