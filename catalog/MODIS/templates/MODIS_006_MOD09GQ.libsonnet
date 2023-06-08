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
        name: 'num_observations',
        description: 'Number of observations per 250m pixel',
      },
      {
        name: 'sur_refl_b01',
        description: 'Surface reflectance band 1',
        center_wavelength: 0.645,
        'gee:scale': 0.0001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'sur_refl_b02',
        description: 'Surface reflectance for band 2',
        center_wavelength: 0.8585,
        'gee:scale': 0.0001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'QC_250m',
        description: 'Surface reflectance quality assurance',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QA bits',
              bit_count: 2,
              values: [
                {
                  description: 'Corrected product produced at ideal quality - all bands',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Corrected product produced at less than ideal quality - some or all bands',
                },
                {
                  value: 2,
                  description: 'Corrected product not produced due to cloud effects - all bands',
                },
                {
                  value: 3,
                  description: |||
                    Corrected product not produced for other reasons
                    - some or all bands, may be fill value (11) [Note that
                    a value of (11) overrides a value of (01)]
                  |||,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Spare (unused)',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
            {
              description: 'Band 1 data quality',
              first_bit: 4,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: 'Internal constant used in place of climatological\ndata for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds, pixel constrained\nto extreme allowable value',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Band 2 data quality',
              first_bit: 8,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: 'Internal constant used in place of climatological\ndata for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds, pixel constrained  to extreme allowable value',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Atmospheric correction performed',
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
              description: 'Adjacency correction performed',
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
              description: 'Spare (unused)',
              first_bit: 14,
              bit_count: 2,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'obscov',
        description: 'Observation coverage percent',
        'gee:scale': 0.01,
      },
      {
        name: 'iobs_res',
        description: 'Observation number',
      },
      {
        name: 'orbit_pnt',
        description: 'Orbit pointer',
      },
      {
        name: 'granule_pnt',
        description: 'Granule pointer',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'sur_refl_b02',
              'sur_refl_b02',
              'sur_refl_b01',
            ],
          },
        },
      },
    ],
    num_observations: {
      minimum: 0.0,
      maximum: 127.0,
      'gee:estimated_range': false,
    },
    sur_refl_b01: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b02: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    obscov: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    iobs_res: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    orbit_pnt: {
      minimum: 0.0,
      maximum: 15.0,
      'gee:estimated_range': false,
    },
    granule_pnt: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
  },
}
