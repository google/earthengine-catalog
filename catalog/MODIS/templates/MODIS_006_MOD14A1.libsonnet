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
        name: 'FireMask',
        description: 'Confidence of fire',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Fire mask pixel classes',
              bit_count: 4,
              values: [
                {
                  value: 1,
                  description: 'Not processed (obsolete; not used since Collection 1)',
                },
                {
                  value: 2,
                  description: 'Not processed (other reason)',
                },
                {
                  value: 3,
                  description: 'Non-fire water pixel',
                },
                {
                  value: 4,
                  description: 'Cloud (land or water)',
                },
                {
                  value: 5,
                  description: 'Non-fire land pixel',
                },
                {
                  value: 6,
                  description: 'Unknown (land or water)',
                },
                {
                  value: 7,
                  description: 'Fire (low confidence, land or water)',
                },
                {
                  value: 8,
                  description: 'Fire (nominal confidence, land or water)',
                },
                {
                  value: 9,
                  description: 'Fire (high confidence, land or water)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 4,
        },
      },
      {
        name: 'MaxFRP',
        description: 'Maximum fire radiative power',
        'gee:units': units.megawatt,
        'gee:scale': 0.1,
      },
      {
        name: 'sample',
        description: 'Position of fire pixel within scan',
      },
      {
        name: 'QA',
        description: 'Pixel quality indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land/water state',
              bit_count: 2,
              values: [
                {
                  description: 'Water',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Coast',
                },
                {
                  value: 2,
                  description: 'Land',
                },
                {
                  value: 3,
                  description: 'Missing data',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Night/day',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Night',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day',
                },
              ],
            },
          ],
          total_bit_count: 3,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fire Mask',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              6000.0,
            ],
            bands: [
              'MaxFRP',
              'FireMask',
              'FireMask',
            ],
          },
        },
      },
    ],
    MaxFRP: {
      minimum: 0.0,
      maximum: 180000.0,
      'gee:estimated_range': false,
    },
    sample: {
      minimum: 0.0,
      maximum: 1353.0,
      'gee:estimated_range': false,
    },
  },
}
