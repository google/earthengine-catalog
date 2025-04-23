local units = import 'units.libsonnet';

{
  description: |||
    The Terra MODIS Vegetation Continuous Fields (VCF)
    product is a sub-pixel-level representation of surface vegetation
    cover estimates globally. Designed to continuously represent
    Earth's terrestrial surface as a proportion of basic vegetation
    traits, it provides a gradation of three surface cover components:
    percent tree cover, percent non-tree cover, and percent bare.
    VCF products provide a continuous, quantitative portrayal of
    land surface cover with improved spatial detail, and hence, are
    widely used in environmental modeling and monitoring applications.

    Generated yearly, the VCF product is produced using monthly
    composites of Terra MODIS 250 and 500 meters Land Surface Reflectance
    data, including all seven bands, and Land Surface Temperature.
  |||,
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'annual',
    'geophysical',
    'global',
    'mod44b',
    'modis',
    'nasa',
    'terra',
    'tree_cover',
    'vegetation',
  ],
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
        'gee:units': units.percent,
      },
      {
        name: 'Percent_NonTree_Vegetation',
        description: 'Percent of a pixel which is covered by non-tree vegetation',
        'gee:units': units.percent,
      },
      {
        name: 'Percent_NonVegetated',
        description: 'Percent of a pixel which is not vegetated',
        'gee:units': units.percent,
      },
      {
        name: 'Quality',
        description: |||
          Describes those inputs that had poor quality (cloudy,
          high aerosol, cloud shadow, or view zenith >45&deg;). Each bit
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
        'gee:units': units.percent,
        'gee:scale': 0.01,
      },
      {
        name: 'Percent_NonVegetated_SD',
        description: |||
          Standard deviation (SD) of the 30 models that were
          used to generate the pixel value in the percent non-vegetated
          data layer
        |||,
        'gee:units': units.percent,
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
        lookat: {lon: 6.746, lat: 46.529, zoom: 3},
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
  sci_citation: |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  gee_interval: {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  gee_terms_of_use: |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
