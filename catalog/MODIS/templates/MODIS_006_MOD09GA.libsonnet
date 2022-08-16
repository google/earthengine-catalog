{
  summaries: {
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'num_observations_1km',
        description: 'Number of observations per 1K pixel',
        gsd: 1000.0,
      },
      {
        name: 'state_1km',
        description: 'Reflectance data state QA',
        gsd: 1000.0,
        'gee:bitmask': {
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
              description: 'BRDF correction performed data',
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
      },
      {
        name: 'SensorZenith',
        description: 'Sensor zenith angle',
        'gee:units': 'Degrees',
        gsd: 1000.0,
        'gee:scale': 0.01,
      },
      {
        name: 'SensorAzimuth',
        description: 'Sensor azimuth angle',
        'gee:units': 'Degrees',
        gsd: 1000.0,
        'gee:scale': 0.01,
      },
      {
        name: 'Range',
        description: 'Distance to sensor',
        'gee:units': 'm',
        gsd: 1000.0,
        'gee:scale': 25.0,
      },
      {
        name: 'SolarZenith',
        description: 'Solar zenith angle',
        'gee:units': 'Degrees',
        gsd: 1000.0,
        'gee:scale': 0.01,
      },
      {
        name: 'SolarAzimuth',
        description: 'Solar azimuth angle',
        'gee:units': 'Degrees',
        gsd: 1000.0,
        'gee:scale': 0.01,
      },
      {
        name: 'gflags',
        description: 'Geolocation flags',
        gsd: 1000.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Fill',
              bit_count: 3,
              values: [
                {
                  description: 'Fill',
                  value: 0,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Sensor range validity flag',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Invalid',
                },
              ],
            },
            {
              description: 'Digital elevation model quality flag',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Missing/inferior',
                },
              ],
            },
            {
              description: 'Terrain data validity',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Invalid',
                },
              ],
            },
            {
              description: 'Ellipsoid intersection flag',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Valid intersection',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'No intersection',
                },
              ],
            },
            {
              description: 'Input data flag',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Invalid',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'orbit_pnt',
        description: 'Orbit pointer',
        gsd: 1000.0,
      },
      {
        name: 'granule_pnt',
        description: 'Granule pointer',
        gsd: 1000.0,
      },
      {
        name: 'num_observations_500m',
        description: 'Number of observations',
        gsd: 500.0,
      },
      {
        name: 'sur_refl_b01',
        description: 'Surface reflectance for band 1',
        center_wavelength: 0.645,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'sur_refl_b02',
        description: 'Surface reflectance for band 2',
        center_wavelength: 0.8585,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'sur_refl_b03',
        description: 'Surface reflectance for band 3',
        center_wavelength: 0.469,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'sur_refl_b04',
        description: 'Surface reflectance for band 4',
        center_wavelength: 0.555,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'sur_refl_b05',
        description: 'Surface reflectance for band 5',
        center_wavelength: 1.24,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'sur_refl_b06',
        description: 'Surface reflectance for band 6',
        center_wavelength: 1.64,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '1628-1652nm',
      },
      {
        name: 'sur_refl_b07',
        description: 'Surface reflectance for band 7',
        center_wavelength: 2.13,
        gsd: 500.0,
        'gee:scale': 0.0001,
        'gee:wavelength': '2105-2155nm',
      },
      {
        name: 'QC_500m',
        description: 'Surface reflectance quality assurance',
        gsd: 500.0,
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
              description: 'Band 1 data quality, four bit range',
              first_bit: 2,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 2 data quality, four bit range',
              first_bit: 6,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 3 data quality, four bit range',
              first_bit: 10,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 4 data quality, four bit range',
              first_bit: 14,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 5 data quality, four bit range',
              first_bit: 18,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 6 data quality, four bit range',
              first_bit: 22,
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
                  description: 'Correction out of bounds, pixel constrained to extreme allowable value',
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
              description: 'Band 7 data quality, four bit range',
              first_bit: 26,
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
              description: 'Atmospheric correction performed',
              first_bit: 30,
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
              first_bit: 31,
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
          total_bit_count: 32,
        },
      },
      {
        name: 'obscov_500m',
        description: 'Observation coverage percent',
        gsd: 500.0,
      },
      {
        name: 'iobs_res',
        description: 'Observation number in coarser grid',
        gsd: 500.0,
      },
      {
        name: 'q_scan',
        description: '250m scan value information',
        gsd: 500.0,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Scan of observation in quadrant 1 [-0.5 row, -0.5 column]',
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
              first_bit: 0,
            },
            {
              description: 'Scan of observation in quadrant 2 [-0.5 row, +0.5 column]',
              first_bit: 1,
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
              description: 'Scan of observation in quadrant 3 [+0.5 row, -0.5 column]',
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
              description: 'Scan of observation in quadrant 4 [+0.5 row, +0.5 column]',
              first_bit: 3,
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
              description: 'Missing observation in quadrant 1 [-0.5 row, -0.5 column]',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Different',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Same',
                },
              ],
            },
            {
              description: 'Missing observation in quadrant 2 [-0.5 row, +0.5 column]',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Different',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Same',
                },
              ],
            },
            {
              description: 'Missing observation in quadrant 3 [+0.5 row, -0.5 column]',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Different',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Same',
                },
              ],
            },
            {
              description: 'Missing observation in quadrant 4 [+0.5 row, +0.5 column]',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Different',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Same',
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
        display_name: 'True color',
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
              8000.0,
            ],
            gamma: [
              1.5,
            ],
            bands: [
              'sur_refl_b01',
              'sur_refl_b04',
              'sur_refl_b03',
            ],
          },
        },
      },
    ],
    num_observations_1km: {
      minimum: 2.0,
      maximum: 127.0,
      'gee:estimated_range': false,
    },
    SensorZenith: {
      minimum: 0.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    SensorAzimuth: {
      minimum: -18000.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    Range: {
      minimum: 27000.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    SolarZenith: {
      minimum: 0.0,
      maximum: 18000.0,
      'gee:estimated_range': false,
    },
    SolarAzimuth: {
      minimum: -18000.0,
      maximum: 18000.0,
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
    num_observations_500m: {
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
    sur_refl_b03: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b04: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b05: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b06: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    sur_refl_b07: {
      minimum: -100.0,
      maximum: 16000.0,
      'gee:estimated_range': false,
    },
    obscov_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    iobs_res: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
  },
}
