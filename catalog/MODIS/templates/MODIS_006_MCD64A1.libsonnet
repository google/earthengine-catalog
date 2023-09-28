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
        name: 'BurnDate',
        description: 'Burn day of year. Possible values: 0 (unburned), 1-366\n(approximate Julian day of burning).',
      },
      {
        name: 'Uncertainty',
        description: 'Estimated uncertainty in burn day',
      },
      {
        name: 'QA',
        description: 'Quality assurance indicators',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land/water',
              bit_count: 1,
              values: [
                {
                  description: 'Water grid cell',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land grid cell',
                },
              ],
              first_bit: 0,
            },
            {
              description: |||
                Valid data flag. A value of 1 indicates that there was
                sufficient valid data in the reflectance time series for the grid
                cell to be processed. (NB Water grid cells will always have this bit
                clear.)
              |||,
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Insufficient valid data',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Sufficient valid data',
                },
              ],
            },
            {
              description: |||
                Shortened mapping period. This flag indicates that the
                period of reliable mapping does not encompass the full one-month
                product period, i.e., burns could not be reliably mapped over the
                full calendar month.
              |||,
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Mapping period not shortened',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Mapping period shortened',
                },
              ],
            },
            {
              description: 'Grid cell was relabeled during the contextual relabeling\nphase of the algorithm.',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Grid cell was not relabeled',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Grid cell was relabeled',
                },
              ],
            },
            {
              description: 'Spare bit',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
            {
              description: |||
                Special condition code reserved for unburned grid cells.
                This code provides an explanation for any grid cells that were
                summarily classified as *unburned* by the detection algorithm due to
                special circumstances.
              |||,
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'None or not applicable (i.e., burned, unmapped, or water grid cell).',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid observations spaced too sparsely in time.',
                },
                {
                  value: 2,
                  description: |||
                    Too few training observations or insufficient spectral
                    separability between burned and unburned classes.
                  |||,
                },
                {
                  value: 3,
                  description: 'Apparent burn date at limits of time series.',
                },
                {
                  value: 4,
                  description: 'Apparent water contamination.',
                },
                {
                  value: 5,
                  description: 'Persistent hot spot.',
                },
                {
                  value: 6,
                  description: 'Reserved for future use.',
                },
                {
                  value: 7,
                  description: 'Reserved for future use.',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'FirstDay',
        description: 'First day of the year of reliable change detection',
      },
      {
        name: 'LastDay',
        description: 'Last day of the year of reliable change detection',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Burned Area',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              30.0,
            ],
            max: [
              341.0,
            ],
            palette: [
              '4e0400',
              '951003',
              'c61503',
              'ff1901',
            ],
            bands: [
              'BurnDate',
            ],
          },
        },
      },
    ],
    BurnDate: {
      minimum: 0.0,
      maximum: 366.0,
      'gee:estimated_range': false,
    },
    Uncertainty: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    FirstDay: {
      minimum: 0.0,
      maximum: 366.0,
      'gee:estimated_range': false,
    },
    LastDay: {
      minimum: 0.0,
      maximum: 366.0,
      'gee:estimated_range': false,
    },
  },
}
