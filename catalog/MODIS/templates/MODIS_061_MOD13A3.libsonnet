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
        name: 'NDVI',
        description: 'Monthly NDVI average',
        'gee:scale': 0.0001,
      },
      {
        name: 'EVI',
        description: 'Monthly EVI average',
        'gee:scale': 0.0001,
      },
      {
        name: 'DetailedQA',
        description: 'VI Quality indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'VI quality (MODLAND QA Bits)',
              bit_count: 2,
              values: [
                {
                  description: 'VI produced with good quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'VI produced, but check other QA',
                },
                {
                  value: 2,
                  description: 'Pixel produced, but most probably cloudy',
                },
                {
                  value: 3,
                  description: 'Pixel not produced due to other reasons than clouds',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'VI usefulness',
              first_bit: 2,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Lower quality',
                },
                {
                  value: 2,
                  description: 'Decreasing quality',
                },
                {
                  value: 4,
                  description: 'Decreasing quality',
                },
                {
                  value: 8,
                  description: 'Decreasing quality',
                },
                {
                  value: 9,
                  description: 'Decreasing quality',
                },
                {
                  value: 10,
                  description: 'Decreasing quality',
                },
                {
                  value: 12,
                  description: 'Lowest quality',
                },
                {
                  value: 13,
                  description: 'Quality so low that it is not useful',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not useful for any other reason/not processed',
                },
              ],
            },
            {
              description: 'Aerosol Quantity',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Intermediate',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Adjacent cloud detected',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Atmosphere BRDF correction',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Mixed Clouds',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Land/water mask',
              first_bit: 11,
              bit_count: 3,
              values: [
                {
                  description: 'Shallow ocean',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land (nothing else but land)',
                },
                {
                  value: 2,
                  description: 'Ocean coastlines and lake shorelines',
                },
                {
                  value: 3,
                  description: 'Shallow inland water',
                },
                {
                  value: 4,
                  description: 'Ephemeral water',
                },
                {
                  value: 5,
                  description: 'Deep inland water',
                },
                {
                  value: 6,
                  description: 'Moderate or continental ocean',
                },
                {
                  value: 7,
                  description: 'Deep ocean',
                },
              ],
            },
            {
              description: 'Possible snow/ice',
              first_bit: 14,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Possible shadow',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'sur_refl_b01',
        description: 'Surface reflectance band 1 (red)',
        center_wavelength: 0.645,
        'gee:scale': 0.0001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'sur_refl_b02',
        description: 'Surface reflectance band 2 (near-infrared)',
        center_wavelength: 0.8585,
        'gee:scale': 0.0001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'sur_refl_b03',
        description: 'Surface reflectance band 3 (blue)',
        center_wavelength: 0.469,
        'gee:scale': 0.0001,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'sur_refl_b07',
        description: 'Surface reflectance band 7 (mid-infrared)',
        center_wavelength: 2.13,
        'gee:scale': 0.0001,
        'gee:wavelength': '2105-2155nm',
      },
      {
        name: 'ViewZenith',
        description: 'View zenith angle of VI Pixel',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'SolarZenith',
        description: 'Sun zenith angle of VI pixel',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'RelativeAzimuth',
        description: 'Relative azimuth angle of VI pixel',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'SummaryQA',
        description: 'Quality reliability of VI pixel',
        'gee:classes': [
          {
            description: 'Good Data: use with confidence',
            value: 0,
          },
          {
            value: 1,
            description: 'Marginal Data: useful, but look at other QA information',
          },
          {
            value: 2,
            description: 'Snow/Ice: target covered with snow/ice',
          },
          {
            value: 3,
            description: 'Cloudy: target not visible, covered with cloud',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NDVI',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              9000.0,
            ],
            palette: [
              'ffffff',
              'ce7e45',
              'df923d',
              'f1b555',
              'fcd163',
              '99b718',
              '74a901',
              '66a000',
              '529400',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '023b01',
              '012e01',
              '011d01',
              '011301',
            ],
            bands: [
              'NDVI',
            ],
          },
        },
      },
    ],
    NDVI: {
      minimum: -2000.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    EVI: {
      minimum: -2000.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b01: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b02: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b03: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b07: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    ViewZenith: {
      minimum: 0.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    SolarZenith: {
      minimum: 0.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    RelativeAzimuth: {
      minimum: -18000.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
  },
}
