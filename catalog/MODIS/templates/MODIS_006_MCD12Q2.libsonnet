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
        name: 'NumCycles',
        description: 'Total number of valid vegetation cycles with peak in product year',
      },
      {
        name: 'Greenup_1',
        description: 'Date when EVI2 first crossed 15% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'Greenup_2',
        description: 'Date when EVI2 first crossed 15% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'MidGreenup_1',
        description: 'Date when EVI2 first crossed 50% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'MidGreenup_2',
        description: 'Date when EVI2 first crossed 50% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'Peak_1',
        description: 'Date when EVI2 reached the segment maximum, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'Peak_2',
        description: 'Date when EVI2 reached the segment maximum, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'Maturity_1',
        description: 'Date when EVI2 first crossed 90% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'Maturity_2',
        description: 'Date when EVI2 first crossed 90% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'MidGreendown_1',
        description: 'Date when EVI2 last crossed 50% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'MidGreendown_2',
        description: 'Date when EVI2 last crossed 50% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'Senescence_1',
        description: 'Date when EVI2 last crossed 90% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'Senescence_2',
        description: 'Date when EVI2 last crossed 90% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'Dormancy_1',
        description: 'Date when EVI2 last crossed 15% of the segment EVI2 amplitude, cycle 1. Days since Jan 1, 1970.',
      },
      {
        name: 'Dormancy_2',
        description: 'Date when EVI2 last crossed 15% of the segment EVI2 amplitude, cycle 2. Days since Jan 1, 1970.',
      },
      {
        name: 'EVI_Minimum_1',
        description: 'Segment minimum EVI2 value, cycle 1',
        'gee:scale': 0.0001,
      },
      {
        name: 'EVI_Minimum_2',
        description: 'Segment minimum EVI2 value, cycle 2',
        'gee:scale': 0.0001,
      },
      {
        name: 'EVI_Amplitude_1',
        description: 'Segment maximum - minimum EVI2, cycle 1',
        'gee:scale': 0.0001,
      },
      {
        name: 'EVI_Amplitude_2',
        description: 'Segment maximum - minimum EVI2, cycle 2',
        'gee:scale': 0.0001,
      },
      {
        name: 'EVI_Area_1',
        description: 'Sum of daily interpolated EVI2 from Greenup to Dormancy, cycle 1',
        'gee:scale': 0.1,
      },
      {
        name: 'EVI_Area_2',
        description: 'Sum of daily interpolated EVI2 from Greenup to Dormancy, cycle 2',
        'gee:scale': 0.1,
      },
      {
        name: 'QA_Overall_1',
        description: 'QA code for entire segment, cycle 1',
        'gee:classes': [
          {
            description: 'Best',
            value: 0,
          },
          {
            value: 1,
            description: 'Good',
          },
          {
            value: 2,
            description: 'Fair',
          },
          {
            value: 3,
            description: 'Poor',
          },
        ],
      },
      {
        name: 'QA_Overall_2',
        description: 'QA code for entire segment, cycle 2',
        'gee:classes': [
          {
            description: 'Best',
            value: 0,
          },
          {
            value: 1,
            description: 'Good',
          },
          {
            value: 2,
            description: 'Fair',
          },
          {
            value: 3,
            description: 'Poor',
          },
        ],
      },
      {
        name: 'QA_Detailed_1',
        description: 'Bit-packed, SDS-specific QA codes, cycle 1',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Greenup QA',
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'MidGreenup QA',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Maturity QA',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Peak QA',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Senescence QA',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'MidGreendown QA',
              first_bit: 10,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Dormancy QA',
              first_bit: 12,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
          ],
          total_bit_count: 14,
        },
      },
      {
        name: 'QA_Detailed_2',
        description: 'Bit-packed, SDS-specific QA codes, cycle 2',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Greenup QA',
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'MidGreenup QA',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Maturity QA',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Peak QA',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Senescence QA',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'MidGreendown QA',
              first_bit: 10,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
            {
              description: 'Dormancy QA',
              first_bit: 12,
              bit_count: 2,
              values: [
                {
                  description: 'Best',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
                {
                  value: 2,
                  description: 'Fair',
                },
                {
                  value: 3,
                  description: 'Poor',
                },
              ],
            },
          ],
          total_bit_count: 14,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Vegetation Peak Date',
        image_visualization: {
          band_vis: {
            min: [
              11400.0,
            ],
            max: [
              11868.0,
            ],
            palette: [
              '0f17ff',
              'b11406',
              'f1ff23',
            ],
            bands: [
              'Peak_1',
            ],
          },
        },
      },
    ],
    NumCycles: {
      minimum: 7.0,
      maximum: 0.0,
      'gee:estimated_range': false,
    },
    Greenup_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Greenup_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    MidGreenup_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    MidGreenup_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Peak_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Peak_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Maturity_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Maturity_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    MidGreendown_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    MidGreendown_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Senescence_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Senescence_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Dormancy_1: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    Dormancy_2: {
      minimum: 11138.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
    EVI_Minimum_1: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    EVI_Minimum_2: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    EVI_Amplitude_1: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    EVI_Amplitude_2: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    EVI_Area_1: {
      minimum: 0.0,
      maximum: 3700.0,
      'gee:estimated_range': false,
    },
    EVI_Area_2: {
      minimum: 0.0,
      maximum: 3700.0,
      'gee:estimated_range': false,
    },
    QA_Overall_1: {
      minimum: 0.0,
      maximum: 3.0,
      'gee:estimated_range': false,
    },
    QA_Overall_2: {
      minimum: 0.0,
      maximum: 3.0,
      'gee:estimated_range': false,
    },
  },
}
