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
        name: 'Snow_BRDF_Albedo',
        description: 'Snow-free or snow BRDF/albedo retrieved',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA',
              bit_count: 1,
              values: [
                {
                  description: 'Snow-free albedo retrieved',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow albedo retrieved',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Platform',
        description: 'BRDF albedo platform information',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Platform',
              bit_count: 2,
              values: [
                {
                  description: 'Terra',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Terra/Aqua',
                },
                {
                  value: 2,
                  description: 'Aqua',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
      {
        name: 'BRDF_Albedo_LandWaterType',
        description: 'Land/water type',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land/water type',
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
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_LocalSolarNoon',
        description: 'Solar zenith angle of local solar noon',
        'gee:units': 'Degrees',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band1',
        description: 'Valid observation for band 1',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Day 1 reflectance quality',
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Day 2 reflectance quality',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 3 reflectance quality',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 4 reflectance quality',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 5 reflectance quality',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 6 reflectance quality',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 7 reflectance quality',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 8 reflectance quality',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 9 reflectance quality',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 10 reflectance quality',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 11 reflectance quality',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 12 reflectance quality',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 13 reflectance quality',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 14 reflectance quality',
              first_bit: 13,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 15 reflectance quality',
              first_bit: 14,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
            {
              description: 'Day 16 reflectance quality',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'Observation not used',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Valid clear observation',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band2',
        description: 'Valid observation for band 2 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band3',
        description: 'Valid observation for band 3 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band4',
        description: 'Valid observation for band 4 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band5',
        description: 'Valid observation for band 5 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band6',
        description: 'Valid observation for band 6 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_ValidObs_Band7',
        description: 'Valid observation for band 7 (same bit meaning as in band 1)',
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band1',
        description: 'BRDF inversion information for band 1',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 1',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band2',
        description: 'BRDF inversion information for band 2',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 2',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band3',
        description: 'BRDF inversion information for band 3',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 3',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band4',
        description: 'BRDF inversion information for band 4',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 4',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band5',
        description: 'BRDF inversion information for band 5',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 5',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band6',
        description: 'BRDF inversion information for band 6',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 6',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 & < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Band_Quality_Band7',
        description: 'BRDF inversion information for band 7',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'BRDF inversion information for band 7',
              bit_count: 3,
              values: [
                {
                  description: 'Best quality, full inversion (WoDs and RMSE are good)',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Good quality, full inversion (also including
                    the cases with no clear sky observations over the day of
                    interest and those with a Solar Zenith Angle that is >
                    70 degrees even though WoDs and RMSE majority are good)
                  |||,
                },
                {
                  value: 2,
                  description: 'Magnitude inversion (numobs ≥ 7)',
                },
                {
                  value: 3,
                  description: 'Magnitude inversion (numobs ≥ 2 and < 7)',
                },
                {
                  value: 4,
                  description: 'Fill value',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
      {
        name: 'BRDF_Albedo_Uncertainty',
        description: 'BRDF inversion information',
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Default visualization',
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
              1.0,
            ],
            bands: [
              'Snow_BRDF_Albedo',
            ],
          },
        },
      },
    ],
    BRDF_Albedo_LocalSolarNoon: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    BRDF_Albedo_Uncertainty: {
      minimum: 0.0,
      maximum: 32766.0,
      'gee:estimated_range': false,
    },
  },
}
