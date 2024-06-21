local units = import 'units.libsonnet';

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
        name: 'Coarse_Resolution_Surface_Reflectance_Band_1',
        description: 'Surface reflectance for band 1',
        'gee:wavelength': '620-670nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_2',
        description: 'Surface reflectance for band 2',
        'gee:wavelength': '841-876nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_3',
        description: 'Surface reflectance for band 3',
        'gee:wavelength': '459-479nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_4',
        description: 'Surface reflectance for band 4',
        'gee:wavelength': '545-565nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_5',
        description: 'Surface reflectance for band 5',
        'gee:wavelength': '1230-1250nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_6',
        description: 'Surface reflectance for band 6',
        'gee:wavelength': '1628-1652nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Surface_Reflectance_Band_7',
        description: 'Surface reflectance for band 7',
        'gee:wavelength': '2105-2155nm',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_Solar_Zenith_Angle',
        description: 'Solar Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'Coarse_Resolution_View_Zenith_Angle',
        description: 'View Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'Coarse_Resolution_Relative_Azimuth_Angle',
        description: 'Relative Azimuth Angle',
        'gee:units': units.degree,
      },
      {
        name: 'Coarse_Resolution_Ozone',
        description: 'Ozone Resolution',
        'gee:units': units.atmosphere_centimeters,
      },
      {
        name: 'Coarse_Resolution_Brightness_Temperature_Band_20',
        description: 'Band 20 Brightness Temperature',
        'gee:wavelength': '3.360-3.840&micro;m',
        'gee:units': units.kelvin,
      },
      {
        name: 'Coarse_Resolution_Brightness_Temperature_Band_21',
        description: 'Band 21 Brightness Temperature',
        'gee:wavelength': '3.929-3.989&micro;m',
        'gee:units': units.kelvin,
      },
      {
        name: 'Coarse_Resolution_Brightness_Temperature_Band_31',
        description: 'Band 31 Brightness Temperature',
        'gee:wavelength': '10.780-11.280&micro;m',
        'gee:units': units.kelvin,
      },
      {
        name: 'Coarse_Resolution_Brightness_Temperature_Band_32',
        description: 'Band 32 Brightness Temperature',
        'gee:wavelength': '11.770-12.270&micro;m',
        'gee:units': units.kelvin,
      },
      {
        name: 'Coarse_Resolution_Granule_Time',
        description: 'Granule time of day, as HHMM',
      },
      {
        name: 'Coarse_Resolution_Band_3_Path_Radiance',
        description: 'Band 3 Radiance',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Coarse_Resolution_QA',
        description: 'Quality Assurance',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QA bits',
              bit_count: 2,
              values: [
                {
                  description: 'Corrected product produced at ideal quality  - all bands',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
                  description: 'Internal constant used in place of climatological data for at least one atmospheric constant',
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
        name: 'Coarse_Resolution_Internal_CM',
        description: 'Internal Cloud Mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloudy',
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
              description: 'Clear',
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
              description: 'High clouds',
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
              description: 'Low clouds',
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
              description: 'Snow',
              first_bit: 4,
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
              description: 'Fire',
              first_bit: 5,
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
              description: 'Sun glint',
              first_bit: 6,
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
              description: 'Dust',
              first_bit: 7,
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
              description: 'Cloud shadow',
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
              description: 'Pixel is adjacent to cloud',
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
              description: 'Cirrus',
              first_bit: 10,
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
              description: 'Pan flag',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'No salt pan',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Salt pan',
                },
              ],
            },
            {
              description: 'Criteria used for aerosol retrieval',
              first_bit: 13,
              bit_count: 1,
              values: [
                {
                  description: 'Criterion 1',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Criterion 2',
                },
              ],
            },
            {
              description: 'AOT (aerosol optical thickness) has climatological values',
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
              description: 'Pixel has interpolated TR, PR or SA data',
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
        name: 'Coarse_Resolution_State_QA',
        description: 'State Quality Assurance',
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
        name: 'Coarse_Resolution_Number_Mapping',
        description: 'Number Mapping Cloud/Snow',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Number of pixel mapping flagged as cloudy',
              bit_count: 8,
              first_bit: 0,
            },
            {
              description: 'Number of pixel mapping flagged as cloud shadow',
              bit_count: 8,
              first_bit: 8,
            },
            {
              description: 'Number of pixel mapping flagged as adjacent to cloud',
              bit_count: 8,
              first_bit: 16,
            },
            {
              description: 'Number of pixel mapping flagged for snow',
              bit_count: 8,
              first_bit: 24,
            },
          ],
          total_bit_count: 32,
        },
      },
      {
        name: 'number_of_500m_pixels_averaged_b3',
        description: 'Number of 500m pixels used in average',
      },
      {
        name: 'number_of_500m_rej_detector',
        description: 'Number of 500m pixels rejected for use',
      },
      {
        name: 'number_of_250m_pixels_averaged_b1-2',
        description: 'Number of 250m pixels used in b1-2 average',
      },
      {
        name: 'n_pixels_averaged',
        description: 'Number of pixels used in average',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.4,
            ],
            max: [
              1.0,
            ],
            bands: [
              'Coarse_Resolution_Surface_Reflectance_Band_1',
              'Coarse_Resolution_Surface_Reflectance_Band_2',
              'Coarse_Resolution_Surface_Reflectance_Band_3',
            ],
          },
        },
      },
    ],
    Coarse_Resolution_Surface_Reflectance_Band_1: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_2: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_3: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_4: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_5: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_6: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Surface_Reflectance_Band_7: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Solar_Zenith_Angle: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_View_Zenith_Angle: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Relative_Azimuth_Angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Ozone: {
      minimum: 0.0025,
      maximum: 0.6375,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Brightness_Temperature_Band_20: {
      minimum: 0.01,
      maximum: 400.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Brightness_Temperature_Band_21: {
      minimum: 0.01,
      maximum: 400.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Brightness_Temperature_Band_31: {
      minimum: 0.01,
      maximum: 400.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Brightness_Temperature_Band_32: {
      minimum: 0.01,
      maximum: 400.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Granule_Time: {
      minimum: 1.0,
      maximum: 2355.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Band_3_Path_Radiance: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_QA: {
      minimum: 1.0,
      maximum: 1073741824.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Internal_CM: {
      minimum: 1.0,
      maximum: 8191.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_State_QA: {
      minimum: 1.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    Coarse_Resolution_Number_Mapping: {
      minimum: 1.0,
      maximum: 2097151.0,
      'gee:estimated_range': false,
    },
    number_of_500m_pixels_averaged_b3: {
      minimum: 1.0,
      maximum: 200.0,
      'gee:estimated_range': false,
    },
    number_of_500m_rej_detector: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'number_of_250m_pixels_averaged_b1-2': {
      minimum: 1.0,
      maximum: 640.0,
      'gee:estimated_range': false,
    },
    n_pixels_averaged: {
      minimum: 1.0,
      maximum: 40.0,
      'gee:estimated_range': false,
    },
  },
}
