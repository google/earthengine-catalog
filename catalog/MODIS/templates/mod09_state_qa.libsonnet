// Shared 16-bit State QA bitmask for MODIS Surface Reflectance (MOD09/MYD09)
// products (`state_1km`, `StateQA`, `State`, and `Coarse_Resolution_State_QA`).
// Collection 6 and 6.1 use Bit 14 for 'Salt pan'; Collection 5 used
// 'BRDF correction performed data'.
{
  bitmask(bit14_description='Salt pan'):: {
    bitmask_parts: [
      {
        description: 'Cloud state',
        bit_count: 2,
        values: [
          {
            description: 'Clear',
            value: 0,
          },
          {
            value: 1,
            description: 'Cloudy',
          },
          {
            value: 2,
            description: 'Mixed',
          },
          {
            value: 3,
            description: 'Not set, assumed clear',
          },
        ],
        first_bit: 0,
      },
      {
        description: 'Cloud shadow',
        first_bit: 2,
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
        description: 'Land/water flag',
        first_bit: 3,
        bit_count: 3,
        values: [
          {
            description: 'Shallow ocean',
            value: 0,
          },
          {
            value: 1,
            description: 'Land',
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
            description: 'Continental/moderate ocean',
          },
          {
            value: 7,
            description: 'Deep ocean',
          },
        ],
      },
      {
        description: 'Aerosol quantity',
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
            description: 'Average',
          },
          {
            value: 3,
            description: 'High',
          },
        ],
      },
      {
        description: 'Cirrus detected',
        first_bit: 8,
        bit_count: 2,
        values: [
          {
            description: 'None',
            value: 0,
          },
          {
            value: 1,
            description: 'Small',
          },
          {
            value: 2,
            description: 'Average',
          },
          {
            value: 3,
            description: 'High',
          },
        ],
      },
      {
        description: 'Internal cloud algorithm flag',
        first_bit: 10,
        bit_count: 1,
        values: [
          {
            description: 'No cloud',
            value: 0,
          },
          {
            value: 1,
            description: 'Cloud',
          },
        ],
      },
      {
        description: 'Internal fire algorithm flag',
        first_bit: 11,
        bit_count: 1,
        values: [
          {
            description: 'No fire',
            value: 0,
          },
          {
            value: 1,
            description: 'Fire',
          },
        ],
      },
      {
        description: 'MOD35 snow/ice flag',
        first_bit: 12,
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
        description: 'Pixel is adjacent to cloud',
        first_bit: 13,
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
        description: bit14_description,
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
        description: 'Internal snow mask',
        first_bit: 15,
        bit_count: 1,
        values: [
          {
            description: 'No snow',
            value: 0,
          },
          {
            value: 1,
            description: 'Snow',
          },
        ],
      },
    ],
    total_bit_count: 16,
  },
}
