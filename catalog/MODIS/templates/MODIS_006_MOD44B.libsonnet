{
  summaries: {
    gsd: [
      250.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Percent_Tree_Cover',
        description: 'Percent of a pixel which is covered by tree canopy',
        'gee:units': '%',
      },
      {
        name: 'Percent_NonTree_Vegetation',
        description: 'Percent of a pixel which is covered by non-tree vegetation',
        'gee:units': '%',
      },
      {
        name: 'Percent_NonVegetated',
        description: 'Percent of a pixel which is not vegetated',
        'gee:units': '%',
      },
      {
        name: 'Quality',
        description: |||
          Describes those inputs that had poor quality (cloudy,
          high aerosol, cloud shadow, or view zenith >45°). Each bit
          in the field represents 1 out of 8 input surface reflectance
          files to the model.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'State of input layers DOY 065-097',
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'State of input layers DOY 113-145',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 161-193',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 209-241',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 257-289',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 305-337',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 353-017',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
            {
              description: 'State of input layers DOY 033-045',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Percent_Tree_Cover_SD',
        description: |||
          Standard deviation (SD) of the 30 models that were
          used to generate the pixel value in the percent tree cover data
          layer
        |||,
        'gee:units': '%',
        'gee:scale': 0.01,
      },
      {
        name: 'Percent_NonVegetated_SD',
        description: |||
          Standard deviation (SD) of the 30 models that were
          used to generate the pixel value in the percent non-vegetated
          data layer
        |||,
        'gee:units': '%',
        'gee:scale': 0.01,
      },
      {
        name: 'Cloud',
        description: |||
          Clarifies the 'Quality' layer to give the user an
          indication that the 'bad' data refers to cloudy input data. Each
          bit in the field represents 1 out of 8 input surface reflectance
          files to the model.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'State of input layers DOY 065-097',
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'State of input layers DOY 113-145',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 161-193',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 209-241',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 257-289',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 305-337',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 353-017',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
              ],
            },
            {
              description: 'State of input layers DOY 033-045',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
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
        display_name: 'Percent Tree Cover',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'bbe029',
              '0a9501',
              '074b03',
            ],
            bands: [
              'Percent_Tree_Cover',
            ],
          },
        },
      },
    ],
    Percent_Tree_Cover: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Percent_NonTree_Vegetation: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Percent_NonVegetated: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Percent_Tree_Cover_SD: {
      minimum: 0.0,
      maximum: 32767.0,
      'gee:estimated_range': false,
    },
    Percent_NonVegetated_SD: {
      minimum: 0.0,
      maximum: 32767.0,
      'gee:estimated_range': false,
    },
  },
}
