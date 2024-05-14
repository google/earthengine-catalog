local units = import 'units.libsonnet';

{
  summaries: {
    gsd: [
      5600.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Majority_Land_Cover_Type_1',
        description: 'Majority Land Cover Type 1: Most likely IGBP class for each 0.05 degree pixel',
        'gee:classes': [
          {
            value: 0,
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
          },
          {
            value: 1,
            color: '05450a',
            description: 'Evergreen Needleleaf Forests: dominated by evergreen\nconifer trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 2,
            color: '086a10',
            description: |||
              Evergreen Broadleaf Forests: dominated by evergreen
              broadleaf and palmate trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 3,
            color: '54a708',
            description: |||
              Deciduous Needleleaf Forests: dominated by deciduous
              needleleaf (larch) trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 4,
            color: '78d203',
            description: 'Deciduous Broadleaf Forests: dominated by deciduous\nbroadleaf trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 5,
            color: '009900',
            description: |||
              Mixed Forests: dominated by neither deciduous nor
              evergreen (40-60% of each) tree type (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 6,
            color: 'c6b044',
            description: 'Closed Shrublands: dominated by woody perennials\n(1-2m height) >60% cover.',
          },
          {
            value: 7,
            color: 'dcd159',
            description: 'Open Shrublands: dominated by woody perennials\n(1-2m height) 10-60% cover.',
          },
          {
            value: 8,
            color: 'dade48',
            description: 'Woody Savannas: tree cover 30-60% (canopy >2m).',
          },
          {
            value: 9,
            color: 'fbff13',
            description: 'Savannas: tree cover 10-30% (canopy >2m).',
          },
          {
            value: 10,
            color: 'b6ff05',
            description: 'Grasslands: dominated by herbaceous annuals (<2m).',
          },
          {
            value: 11,
            color: '27ff87',
            description: 'Permanent Wetlands: permanently inundated lands with\n30-60% water cover and >10% vegetated cover.',
          },
          {
            value: 12,
            color: 'c24f44',
            description: 'Croplands: at least 60% of area is cultivated\ncropland.',
          },
          {
            value: 13,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% impervious
              surface area including building materials, asphalt and vehicles.
            |||,
          },
          {
            value: 14,
            color: 'ff6d4c',
            description: |||
              Cropland/Natural Vegetation Mosaics: mosaics of
              small-scale cultivation 40-60% with natural tree, shrub, or herbaceous
              vegetation.
            |||,
          },
          {
            value: 15,
            color: '69fff8',
            description: |||
              Permanent Snow and Ice: at least 60% of area is covered
              by snow and ice for at least 10 months of the year.
            |||,
          },
          {
            value: 16,
            color: 'f9ffa4',
            description: |||
              Barren: at least 60% of area is non-vegetated barren
              (sand, rock, soil) areas with less than 10% vegetation.
            |||,
          },
        ],
      },
      {
        name: 'Majority_Land_Cover_Type_1_Assessment',
        description: 'Majority Land Cover Type 1 Assessment: Majority IGBP class confidence',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_0',
        description: 'Percent cover of IGBP class 0 (Water Bodies) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_1',
        description: 'Percent cover of IGBP class 1 (Evergreen Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_2',
        description: 'Percent cover of IGBP class 2 (Evergreen Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_3',
        description: 'Percent cover of IGBP class 3 (Deciduous Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_4',
        description: 'Percent cover of IGBP class 4 (Deciduous Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_5',
        description: 'Percent cover of IGBP class 5 (Mixed Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_6',
        description: 'Percent cover of IGBP class 6 (Closed Shrublands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_7',
        description: 'Percent cover of IGBP class 7 (Open Shrublands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_8',
        description: 'Percent cover of IGBP class 8 (Woody Savannas) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_9',
        description: 'Percent cover of IGBP class 9 (Savannas) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_10',
        description: 'Percent cover of IGBP class 10 (Grasslands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_11',
        description: 'Percent cover of IGBP class 11 (Permanent Wetlands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_12',
        description: 'Percent cover of IGBP class 12 (Croplands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_13',
        description: 'Percent cover of IGBP class 13 (Urban and Built-up Lands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_14',
        description: 'Percent cover of IGBP class 14 (Cropland/Natural Vegetation Mosaics) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_15',
        description: 'Percent cover of IGBP class 15 (Permanent Snow and Ice) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_1_Percent_Class_16',
        description: 'Percent cover of IGBP class 16 (Barren) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Majority_Land_Cover_Type_2',
        description: 'Majority Land Cover Type 2: Most likely UMD class for each 0.05 degree pixel',
        'gee:classes': [
          {
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
            value: 0,
          },
          {
            value: 1,
            color: '05450a',
            description: 'Evergreen Needleleaf Forests: dominated by evergreen\nconifer trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 2,
            color: '086a10',
            description: |||
              Evergreen Broadleaf Forests: dominated by evergreen
              broadleaf and palmate trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 3,
            color: '54a708',
            description: |||
              Deciduous Needleleaf Forests: dominated by deciduous
              needleleaf (larch) trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 4,
            color: '78d203',
            description: 'Deciduous Broadleaf Forests: dominated by deciduous\nbroadleaf trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 5,
            color: '009900',
            description: |||
              Mixed Forests: dominated by neither deciduous nor
              evergreen (40-60% of each) tree type (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 6,
            color: 'c6b044',
            description: 'Closed Shrublands: dominated by woody perennials\n(1-2m height) >60% cover.',
          },
          {
            value: 7,
            color: 'dcd159',
            description: 'Open Shrublands: dominated by woody perennials\n(1-2m height) 10-60% cover.',
          },
          {
            value: 8,
            color: 'dade48',
            description: 'Woody Savannas: tree cover 30-60% (canopy >2m).',
          },
          {
            value: 9,
            color: 'fbff13',
            description: 'Savannas: tree cover 10-30% (canopy >2m).',
          },
          {
            value: 10,
            color: 'b6ff05',
            description: 'Grasslands: dominated by herbaceous annuals (<2m).',
          },
          {
            value: 12,
            color: 'c24f44',
            description: 'Croplands: at least 60% of area is cultivated\ncropland.',
          },
          {
            value: 13,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% impervious
              surface area including building materials, asphalt and vehicles.
            |||,
          },
          {
            value: 15,
            color: 'f9ffa4',
            description: |||
              Barren: at least 60% of area is
              non-vegetated barren (sand, rock, soil) or permanent snow and ice with
              less than 10% vegetation.
            |||,
          },
        ],
      },
      {
        name: 'Majority_Land_Cover_Type_2_Assessment',
        description: 'Majority Land Cover Type 2 Assessment: Majority UMD class confidence',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_0',
        description: 'Percent cover of UMD class 0 (Water Bodies) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_1',
        description: 'Percent cover of UMD class 1 (Evergreen Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_2',
        description: 'Percent cover of UMD class 2 (Evergreen Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_3',
        description: 'Percent cover of UMD class 3 (Deciduous Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_4',
        description: 'Percent cover of UMD class 4 (Deciduous Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_5',
        description: 'Percent cover of UMD class 5 (Mixed Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_6',
        description: 'Percent cover of UMD class 6 (Closed Shrublands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_7',
        description: 'Percent cover of UMD class 7 (Open Shrublands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_8',
        description: 'Percent cover of UMD class 8 (Woody Savannas) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_9',
        description: 'Percent cover of UMD class 9 (Savannas) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_10',
        description: 'Percent cover of UMD class 10 (Grasslands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_11',
        description: 'Percent cover of UMD class 11 (Croplands) at each pixel. (Note that "Croplands" has value 12 in Majority_Land_Cover_Type_2 to match IGBP.)',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_12',
        description: 'Percent cover of UMD class 12 (Urban and Built-up Lands) at each pixel. (Note that "Urban and Built-up Lands" has value 13 in Majority_Land_Cover_Type_2 to match IGBP.)',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_2_Percent_Class_13',
        description: 'Percent cover of UMD class 13 (Barren) at each pixel. (Note that "Barren" has value 15 in Majority_Land_Cover_Type_2.)',
        'gee:units': units.percent,
      },
      {
        name: 'Majority_Land_Cover_Type_3',
        description: 'Majority Land Cover Type 3: Most likely LAI class for each 0.05 degree pixel',
        'gee:classes': [
          {
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by permanent water bodies.',
            value: 0,
          },
          {
            value: 1,
            color: 'b6ff05',
            description: 'Grasslands: dominated by herbaceous annuals (<2m) including cereal croplands.',
          },
          {
            value: 2,
            color: 'dcd159',
            description: 'Shrublands: shrub (1-2m) cover >10%.',
          },
          {
            value: 3,
            color: 'c24f44',
            description: 'Broadleaf Croplands: bominated by herbaceous annuals\n(<2m) that are cultivated with broadleaf crops.',
          },
          {
            value: 4,
            color: 'fbff13',
            description: 'Savannas: between 10-60% tree cover (>2m).',
          },
          {
            value: 5,
            color: '086a10',
            description: |||
              Evergreen Broadleaf Forests: dominated by evergreen
              broadleaf and palmate trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 6,
            color: '78d203',
            description: 'Deciduous Broadleaf Forests: dominated by deciduous\nbroadleaf trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 7,
            color: '05450a',
            description: 'Evergreen Needleleaf Forests: dominated by evergreen\nconifer trees (canopy >2m). Tree cover >60%.',
          },
          {
            value: 8,
            color: '54a708',
            description: |||
              Deciduous Needleleaf Forests: dominated by deciduous
              needleleaf (larch) trees (canopy >2m). Tree cover >60%.
            |||,
          },
          {
            value: 9,
            color: 'f9ffa4',
            description: |||
              Unvegetated: at least 60% of area is
              non-vegetated barren (sand, rock, soil) or permanent snow and ice with
              less than 10% vegetation.
            |||,
          },
          {
            value: 10,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% impervious
              surface area including building materials, asphalt and vehicles.
            |||,
          },
        ],
      },
      {
        name: 'Majority_Land_Cover_Type_3_Assessment',
        description: 'Majority Land Cover Type 3 Assessment: Majority LAI class confidence',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_0',
        description: 'Percent cover of LAI class 0 (Water Bodies) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_1',
        description: 'Percent cover of LAI class 1 (Grasslands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_2',
        description: 'Percent cover of LAI class 2 (Shrublands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_3',
        description: 'Percent cover of LAI class 3 (Broadleaf Croplands) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_4',
        description: 'Percent cover of LAI class 4 (Savannas) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_5',
        description: 'Percent cover of LAI class 5 (Evergreen Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_6',
        description: 'Percent cover of LAI class 6 (Deciduous Broadleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_7',
        description: 'Percent cover of LAI class 7 (Evergreen Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_8',
        description: 'Percent cover of LAI class 8 (Deciduous Needleleaf Forests) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_9',
        description: 'Percent cover of LAI class 9 (Unvegetated) at each pixel',
        'gee:units': units.percent,
      },
      {
        name: 'Land_Cover_Type_3_Percent_Class_10',
        description: 'Percent cover of LAI class 10 (Urban and Built-up Lands) at each pixel',
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'IGBP Land Cover',
        lookat: {lon: 6.746, lat: 46.529, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              16.0,
            ],
            palette: [
              '1c0dff',
              '05450a',
              '086a10',
              '54a708',
              '78d203',
              '009900',
              'c6b044',
              'dcd159',
              'dade48',
              'fbff13',
              'b6ff05',
              '27ff87',
              'c24f44',
              'a5a5a5',
              'ff6d4c',
              '69fff8',
              'f9ffa4',
            ],
            bands: [
              'Majority_Land_Cover_Type_1',
            ],
          },
        },
      },
    ],
    Majority_Land_Cover_Type_1: {
      minimum: 0.0,
      maximum: 16.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_1_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_0: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_1: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_2: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_3: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_4: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_5: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_6: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_7: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_8: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_9: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_10: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_11: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_12: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_13: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_14: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_15: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_1_Percent_Class_16: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_2: {
      minimum: 0.0,
      maximum: 15.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_2_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_0: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_1: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_2: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_3: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_4: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_5: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_6: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_7: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_8: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_9: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_10: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_11: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_12: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_2_Percent_Class_13: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_3: {
      minimum: 0.0,
      maximum: 10.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_3_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_0: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_1: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_2: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_3: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_4: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_5: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_6: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_7: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_8: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_9: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Land_Cover_Type_3_Percent_Class_10: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
