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
        name: 'NDSI_Snow_Cover',
        description: |||
          NDSI snow cover. This value is
          computed for MOD10_L2 and retrieved when the observation of
          the day is selected. Provider values above 100 are masked out in
          this band (they can be found in the "NDSI_Snow_Cover_Class" band).
        |||,
      },
      {
        name: 'NDSI_Snow_Cover_Basic_QA',
        description: |||
          A basic estimate of the quality of the algorithm result.
          This value is computed for MOD10_L2 and retrieved with the corresponding
          observation of the day.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'QA',
              bit_count: 16,
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
                  description: 'Ok',
                },
                {
                  value: 3,
                  description: 'Poor - not currently in use',
                },
                {
                  value: 211,
                  description: 'Night',
                },
                {
                  value: 239,
                  description: 'Ocean',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 16,
        },
      },
      {
        name: 'NDSI_Snow_Cover_Algorithm_Flags_QA',
        description: |||
          Bit flags indicating screen results and the presence
          of inland water. These flags are set when MOD10_L2 is generated
          and retrieved with the corresponding observation of the day.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Inland water',
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
              description: 'Low visible screen failed. Snow detection reversed.',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'No fail/not reversed',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The MODIS band 2 reflectance is <= 0.10\nor the band 4 reflectance is <= 0.11',
                },
              ],
            },
            {
              description: 'Low NDSI screen failed. Snow detection reversed.',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'No fail/not reversed',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixels detected as having snow cover with 0.0\n< NDSI < 0.10 are reversed to no snow',
                },
              ],
            },
            {
              description: 'Combined temperature/height screen failed.',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  value: 1,
                  description: |||
                    Brightness temperature >= 281K, pixel height
                    < 1300m, flag set, snow detection reversed to not snow
                    or brightness temperature >= 281K, pixel height >=
                    1300m, flag set, snow detection NOT reversed.
                  |||,
                },
              ],
            },
            {
              description: 'Shortwave IR (SWIR) reflectance anomalously high.',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  value: 1,
                  description: |||
                    Snow pixel with SWIR > 0.45, flag set, snow
                    detection reversed to not snow or snow pixel with 25%
                    < SWIR <= 45%, flag set to indicate unusual snow
                    condition, snow detection NOT reversed.
                  |||,
                },
              ],
            },
            {
              description: 'Spare',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
            {
              description: 'Spare',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'N/A',
                  value: 0,
                },
              ],
            },
            {
              description: 'Solar zenith screen failed (angles exceed 70°), uncertainty increased.',
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
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'NDSI',
        description: |||
          Raw NDSI (i.e. prior to screening). This value is
          computed for MOD10_L2 and retrieved with the corresponding observation
          of the day.
        |||,
        'gee:scale': 0.0001,
      },
      {
        name: 'Snow_Albedo_Daily_Tile',
        description: |||
          Snow albedo percentage. Provider values above 100 are masked out in
          this band (they can be found in the "Snow_Albedo_Daily_Tile_Class" band).
        |||,
      },
      {
        name: 'orbit_pnt',
        description: |||
          Pointer to the orbit number of the swath that was
          selected as the observation of the day. The pointer references
          by index the list of orbit numbers written to the ORBITNUMBERARRAY
          metadata object in ArchiveMetadata.0.
        |||,
      },
      {
        name: 'granule_pnt',
        description: |||
          Pointer to the granule (swath) that was mapped into
          the tile. The pointer references the corresponding value in the
          GRANULEPOINTERARRAY metadata object written to ArchiveMetadata.0.
        |||,
      },
      {
        name: 'NDSI_Snow_Cover_Class',
        description: |||
          Landcover classes from the "NDSI_Snow_Cover" subdataset
          (provider values less than or equal to 100 are masked out).
        |||,
        'gee:classes': [
          {
            value: 200,
            description: 'Missing data',
          },
          {
            value: 201,
            description: 'No decision',
          },
          {
            value: 211,
            description: 'Night',
          },
          {
            value: 237,
            description: 'Inland water',
          },
          {
            value: 239,
            description: 'Ocean',
          },
          {
            value: 250,
            description: 'Cloud',
          },
          {
            value: 254,
            description: 'Detector saturated',
          },
        ],
      },
      {
        name: 'Snow_Albedo_Daily_Tile_Class',
        description: |||
          Landcover classes from the "Snow_Albedo_Daily_Tile" subdataset
          (provider values less than or equal to 100 are masked out).
        |||,
        'gee:classes': [
          {
            value: 101,
            description: 'No decision',
          },
          {
            value: 111,
            description: 'Night',
          },
          {
            value: 125,
            description: 'Land',
          },
          {
            value: 137,
            description: 'Inland water',
          },
          {
            value: 139,
            description: 'Ocean',
          },
          {
            value: 150,
            description: 'Cloud',
          },
          {
            value: 151,
            description: 'Cloud detected as snow',
          },
          {
            value: 250,
            description: 'Missing',
          },
          {
            value: 251,
            description: 'Self-shadowing',
          },
          {
            value: 252,
            description: 'Land mask mismatch',
          },
          {
            value: 253,
            description: 'BRDF failure',
          },
          {
            value: 254,
            description: 'Non-production mask',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Snow Cover',
        lookat: {
          lat: 76.35,
          lon: -41.13,
          zoom: 3,
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
              'black',
              '0dffff',
              '0524ff',
              'ffffff',
            ],
            bands: [
              'NDSI_Snow_Cover',
            ],
          },
        },
      },
    ],
    NDSI_Snow_Cover: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    NDSI: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Snow_Albedo_Daily_Tile: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
