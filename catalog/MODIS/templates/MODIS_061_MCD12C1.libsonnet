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
        name: 'Majority_Land_Cover_Type_1_Percent',
        description: 'Majority Land Cover Type 1 Percent: Percent cover of each IGBP class at each pixel',
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
        name: 'Majority_Land_Cover_Type_2_Percent',
        description: 'Majority Land Cover Type 2 Percent: Percent cover of each UMD class at each pixel',
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
        name: 'Majority_Land_Cover_Type_3_Percent',
        description: 'Majority Land Cover Type 3 Percent: Percent cover of each LAI class at each pixel',
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
    Majority_Land_Cover_Type_2: {
      minimum: 0.0,
      maximum: 15.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_3: {
      minimum: 0.0,
      maximum: 10.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_1_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_1_Percent: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_2_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_2_Percent: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_3_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Majority_Land_Cover_Type_3_Percent: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
