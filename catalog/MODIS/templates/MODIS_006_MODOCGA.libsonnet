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
        name: 'num_observations',
        description: 'Number of observations per pixel',
      },
      {
        name: 'sur_refl_b08',
        description: 'MODIS band 8 surface reflectance',
        center_wavelength: 0.4125,
        'gee:scale': 0.0001,
        'gee:wavelength': '405-420nm',
      },
      {
        name: 'sur_refl_b09',
        description: 'MODIS band 9 surface reflectance',
        center_wavelength: 0.443,
        'gee:scale': 0.0001,
        'gee:wavelength': '438-448nm',
      },
      {
        name: 'sur_refl_b10',
        description: 'MODIS band 10 surface reflectance',
        center_wavelength: 0.488,
        'gee:scale': 0.0001,
        'gee:wavelength': '483-493nm',
      },
      {
        name: 'sur_refl_b11',
        description: 'MODIS band 11 surface reflectance',
        center_wavelength: 0.531,
        'gee:scale': 0.0001,
        'gee:wavelength': '526-536nm',
      },
      {
        name: 'sur_refl_b12',
        description: 'MODIS band 12 surface reflectance',
        center_wavelength: 0.551,
        'gee:scale': 0.0001,
        'gee:wavelength': '546-556nm',
      },
      {
        name: 'sur_refl_b13',
        description: 'MODIS band 13 surface reflectance',
        center_wavelength: 0.667,
        'gee:scale': 0.0001,
        'gee:wavelength': '662-672nm',
      },
      {
        name: 'sur_refl_b14',
        description: 'MODIS band 14 surface reflectance',
        center_wavelength: 0.677,
        'gee:scale': 0.0001,
        'gee:wavelength': '673-683nm',
      },
      {
        name: 'sur_refl_b15',
        description: 'MODIS band 15 surface reflectance',
        center_wavelength: 0.747,
        'gee:scale': 0.0001,
        'gee:wavelength': '743-753nm',
      },
      {
        name: 'sur_refl_b16',
        description: 'MODIS band 16 surface reflectance',
        center_wavelength: 0.8695,
        'gee:scale': 0.0001,
        'gee:wavelength': '862-877nm',
      },
      {
        name: 'QC_b8_15_1km',
        description: 'Band quality for MODIS bands 8-15',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Band 8 data quality',
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              first_bit: 0,
            },
            {
              description: 'Band 9 data quality',
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 10 data quality',
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 11 data quality',
              first_bit: 12,
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 12 data quality',
              first_bit: 16,
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 13 data quality',
              first_bit: 20,
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 14 data quality',
              first_bit: 24,
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
              description: 'Band 15 data quality',
              first_bit: 28,
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
          ],
          total_bit_count: 32,
        },
      },
      {
        name: 'QC_b16_15_1km',
        description: 'Band quality for MODIS band 16',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Unused',
              bit_count: 4,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Band 16 data quality',
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
                  description: 'Dead detector; data interpolated in L1B',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
                },
                {
                  value: 13,
                  description: 'Correction out of bounds pixel constrained to extreme allowable value',
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
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'orbit_pnt',
        description: 'Pointer to the orbit of each observation',
      },
      {
        name: 'granule_pnt',
        description: 'Pointer to the granule of each observation',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              2000.0,
            ],
            bands: [
              'sur_refl_b11',
              'sur_refl_b10',
              'sur_refl_b09',
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
    sur_refl_b08: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b09: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b10: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b11: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b12: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b13: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b14: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b15: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b16: {
      minimum: -100.0,
      maximum: 16000.0,
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
