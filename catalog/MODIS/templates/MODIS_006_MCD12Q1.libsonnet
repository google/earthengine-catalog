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
        name: 'LC_Type1',
        description: 'Land Cover Type 1: Annual International Geosphere-Biosphere Programme (IGBP) classification',
        'gee:classes': [
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
          {
            value: 17,
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
          },
        ],
      },
      {
        name: 'LC_Type2',
        description: 'Land Cover Type 2: Annual University of Maryland (UMD) classification',
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
            color: 'f9ffa4',
            description: |||
              Non-Vegetated Lands: at least 60% of area is
              non-vegetated barren (sand, rock, soil) or permanent snow and ice with
              less than 10% vegetation.
            |||,
          },
        ],
      },
      {
        name: 'LC_Type3',
        description: 'Land Cover Type 3: Annual Leaf Area Index (LAI) classification',
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
              Non-Vegetated Lands: at least 60% of area is
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
        name: 'LC_Type4',
        description: 'Land Cover Type 4: Annual BIOME-Biogeochemical Cycles (BGC) classification',
        'gee:classes': [
          {
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
            value: 0,
          },
          {
            value: 1,
            color: '05450a',
            description: |||
              Evergreen Needleleaf Vegetation: dominated by evergreen
              conifer trees and shrubs (>1m). Woody vegetation cover >10%.
            |||,
          },
          {
            value: 2,
            color: '086a10',
            description: |||
              Evergreen Broadleaf Vegetation: dominated by evergreen
              broadleaf and palmate trees and shrubs (>1m). Woody vegetation cover
              >10%.
            |||,
          },
          {
            value: 3,
            color: '54a708',
            description: |||
              Deciduous Needleleaf Vegetation: dominated by deciduous
              needleleaf (larch) trees and shrubs (>1m). Woody vegetation cover
              >10%.
            |||,
          },
          {
            value: 4,
            color: '78d203',
            description: |||
              Deciduous Broadleaf Vegetation: dominated by deciduous
              broadleaf trees and shrubs (>1m). Woody vegetation cover >10%.
            |||,
          },
          {
            value: 5,
            color: '009900',
            description: |||
              Annual Broadleaf Vegetation: dominated by herbaceous
              annuals (<2m). At least 60% cultivated broadleaf crops.
            |||,
          },
          {
            value: 6,
            color: 'b6ff05',
            description: 'Annual Grass Vegetation: dominated by herbaceous\nannuals (<2m) including cereal croplands.',
          },
          {
            value: 7,
            color: 'f9ffa4',
            description: |||
              Non-Vegetated Lands: at least 60% of area is
              non-vegetated barren (sand, rock, soil) or permanent snow/ice with
              less than 10% vegetation.
            |||,
          },
          {
            value: 8,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% impervious
              surface area including building materials, asphalt, and vehicles.
            |||,
          },
        ],
      },
      {
        name: 'LC_Type5',
        description: 'Land Cover Type 5: Annual Plant Functional Types classification',
        'gee:classes': [
          {
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by permanent water bodies.',
            value: 0,
          },
          {
            value: 1,
            color: '05450a',
            description: 'Evergreen Needleleaf Trees: dominated by evergreen\nconifer trees (>2m). Tree cover >10%.',
          },
          {
            value: 2,
            color: '086a10',
            description: 'Evergreen Broadleaf Trees: dominated by evergreen\nbroadleaf and palmate trees (>2m). Tree cover >10%.',
          },
          {
            value: 3,
            color: '54a708',
            description: 'Deciduous Needleleaf Trees: dominated by deciduous\nneedleleaf (larch) trees (>2m). Tree cover >10%.',
          },
          {
            value: 4,
            color: '78d203',
            description: 'Deciduous Broadleaf Trees: dominated by deciduous\nbroadleaf trees (>2m). Tree cover >10%.',
          },
          {
            value: 5,
            color: 'dcd159',
            description: 'Shrub: Shrub (1-2m) cover >10%.',
          },
          {
            value: 6,
            color: 'b6ff05',
            description: 'Grass: dominated by herbaceous annuals (<2m) that are\nnot cultivated.',
          },
          {
            value: 7,
            color: 'dade48',
            description: 'Cereal Croplands: dominated by herbaceous annuals\n(<2m). At least 60% cultivated cereal crops.',
          },
          {
            value: 8,
            color: 'c24f44',
            description: 'Broadleaf Croplands: dominated by herbaceous annuals\n(<2m). At least 60% cultivated broadleaf crops.',
          },
          {
            value: 9,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% impervious
              surface area including building materials, asphalt, and vehicles.
            |||,
          },
          {
            value: 10,
            color: '69fff8',
            description: |||
              Permanent Snow and Ice: at least 60% of area is covered
              by snow and ice for at least 10 months of the year.
            |||,
          },
          {
            value: 11,
            color: 'f9ffa4',
            description: |||
              Non-Vegetated Lands: at least 60% of area is
              non-vegetated barren (sand, rock, soil) with
              less than 10% vegetation.
            |||,
          },
        ],
      },
      {
        name: 'LC_Prop1_Assessment',
        description: 'LCCS1 land cover layer confidence',
        'gee:units': units.percent,
      },
      {
        name: 'LC_Prop2_Assessment',
        description: 'LCCS2 land use layer confidence',
        'gee:units': units.percent,
      },
      {
        name: 'LC_Prop3_Assessment',
        description: 'LCCS3 surface hydrology layer confidence',
        'gee:units': units.percent,
      },
      {
        name: 'LC_Prop1',
        description: 'FAO-Land Cover Classification System 1 (LCCS1) land cover layer',
        'gee:classes': [
          {
            value: 1,
            color: 'f9ffa4',
            description: |||
              Barren: at least of area 60% is non-vegetated barren
              (sand, rock, soil) or permanent snow/ice with less than 10%
              vegetation.
            |||,
          },
          {
            value: 2,
            color: '69fff8',
            description: |||
              Permanent Snow and Ice: at least 60% of area is covered
              by snow and ice for at least 10 months of the year.
            |||,
          },
          {
            value: 3,
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
          },
          {
            value: 11,
            color: '05450a',
            description: 'Evergreen Needleleaf Forests: dominated by evergreen\nconifer trees (>2m). Tree cover >60%.',
          },
          {
            value: 12,
            color: '086a10',
            description: |||
              Evergreen Broadleaf Forests: dominated by evergreen
              broadleaf and palmate trees (>2m). Tree cover >60%.
            |||,
          },
          {
            value: 13,
            color: '54a708',
            description: 'Deciduous Needleleaf Forests: dominated by deciduous\nneedleleaf (larch) trees (>2m). Tree cover >60%.',
          },
          {
            value: 14,
            color: '78d203',
            description: 'Deciduous Broadleaf Forests: dominated by deciduous\nbroadleaf trees (>2m). Tree cover >60%.',
          },
          {
            value: 15,
            color: '005a00',
            description: |||
              Mixed Broadleaf/Needleleaf Forests: co-dominated
              (40-60%) by broadleaf deciduous and evergreen needleleaf tree (>2m)
              types. Tree cover >60%.
            |||,
          },
          {
            value: 16,
            color: '009900',
            description: |||
              Mixed Broadleaf Evergreen/Deciduous Forests:
              co-dominated (40-60%) by broadleaf evergreen and deciduous tree (>2m)
              types. Tree cover >60%.
            |||,
          },
          {
            value: 21,
            color: '006c00',
            description: 'Open Forests: tree cover 30-60% (canopy >2m).',
          },
          {
            value: 22,
            color: '00d000',
            description: 'Sparse Forests: tree cover 10-30% (canopy >2m).',
          },
          {
            value: 31,
            color: 'b6ff05',
            description: 'Dense Herbaceous: dominated by herbaceous annuals\n(<2m) at least 60% cover.',
          },
          {
            value: 32,
            color: '98d604',
            description: 'Sparse Herbaceous: dominated by herbaceous annuals\n(<2m) 10-60% cover.',
          },
          {
            value: 41,
            color: 'dcd159',
            description: 'Dense Shrublands: dominated by woody perennials (1-2m)\n>60% cover.',
          },
          {
            value: 42,
            color: 'f1fb58',
            description: |||
              Shrubland/Grassland Mosaics: dominated by woody
              perennials (1-2m) 10-60% cover with dense herbaceous annual
              understory.
            |||,
          },
          {
            value: 43,
            color: 'fbee65',
            description: |||
              Sparse Shrublands: dominated by woody perennials (1-2m)
              10-60% cover with minimal herbaceous understory.
            |||,
          },
        ],
      },
      {
        name: 'LC_Prop2',
        description: 'FAO-LCCS2 land use layer',
        'gee:classes': [
          {
            value: 1,
            color: 'f9ffa4',
            description: |||
              Barren: at least of area 60% is non-vegetated barren
              (sand, rock, soil) or permanent snow/ice with less than 10%
              vegetation.
            |||,
          },
          {
            value: 2,
            color: '69fff8',
            description: |||
              Permanent Snow and Ice: at least 60% of area is covered
              by snow and ice for at least 10 months of the year.
            |||,
          },
          {
            value: 3,
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
          },
          {
            value: 9,
            color: 'a5a5a5',
            description: |||
              Urban and Built-up Lands: at least 30% of area is made
              up ofimpervious surfaces including building materials, asphalt, and
              vehicles.
            |||,
          },
          {
            value: 10,
            color: '003f00',
            description: 'Dense Forests: tree cover >60% (canopy >2m).',
          },
          {
            value: 20,
            color: '006c00',
            description: 'Open Forests: tree cover 10-60% (canopy >2m).',
          },
          {
            value: 25,
            color: 'e3ff77',
            description: 'Forest/Cropland Mosaics: mosaics of small-scale\ncultivation 40-60% with >10% natural tree cover.',
          },
          {
            value: 30,
            color: 'b6ff05',
            description: 'Natural Herbaceous: dominated by herbaceous annuals\n(<2m). At least 10% cover.',
          },
          {
            value: 35,
            color: '93ce04',
            description: |||
              Natural Herbaceous/Croplands Mosaics: mosaics of
              small-scale cultivation 40-60% with natural shrub or herbaceous
              vegetation.
            |||,
          },
          {
            value: 36,
            color: '77a703',
            description: |||
              Herbaceous Croplands: dominated by herbaceous annuals
              (<2m). At least 60% cover. Cultivated fraction >60%.
            |||,
          },
          {
            value: 40,
            color: 'dcd159',
            description: 'Shrublands: shrub cover >60% (1-2m).',
          },
        ],
      },
      {
        name: 'LC_Prop3',
        description: 'FAO-LCCS3 surface hydrology layer',
        'gee:classes': [
          {
            value: 1,
            color: 'f9ffa4',
            description: |||
              Barren: at least of area 60% is non-vegetated barren
              (sand, rock, soil) or permanent snow/ice with less than 10%
              vegetation.
            |||,
          },
          {
            value: 2,
            color: '69fff8',
            description: |||
              Permanent Snow and Ice: at least 60% of area is covered
              by snow and ice for at least 10 months of the year.
            |||,
          },
          {
            value: 3,
            color: '1c0dff',
            description: 'Water Bodies: at least 60% of area is covered by\npermanent water bodies.',
          },
          {
            value: 10,
            color: '003f00',
            description: 'Dense Forests: tree cover >60% (canopy >2m).',
          },
          {
            value: 20,
            color: '006c00',
            description: 'Open Forests: tree cover 10-60% (canopy >2m).',
          },
          {
            value: 27,
            color: '72834a',
            description: 'Woody Wetlands: shrub and tree cover >10% (>1m).\nPermanently or seasonally inundated.',
          },
          {
            value: 30,
            color: 'b6ff05',
            description: 'Grasslands: dominated by herbaceous annuals (<2m) >10% cover.',
          },
          {
            value: 40,
            color: 'c6b044',
            description: 'Shrublands: shrub cover >60% (1-2m).',
          },
          {
            value: 50,
            color: '3aba73',
            description: |||
              Herbaceous Wetlands: dominated by herbaceous annuals
              (<2m) >10% cover. Permanently or seasonally inundated.
            |||,
          },
          {
            value: 51,
            color: '1e9db3',
            description: 'Tundra: tree cover <10%. Snow-covered for at least 8\nmonths of the year.',
          },
        ],
      },
      {
        name: 'QC',
        description: 'Product quality flags',
        'gee:classes': [
          {
            description: 'Classified land: has a classification label and is land\naccording to the water mask.',
            value: 0,
          },
          {
            value: 1,
            description: |||
              Unclassified land: not classified because of missing
              data but land according to the water mask, labeled as barren.
            |||,
          },
          {
            value: 2,
            description: 'Classified water: has a classification label and is\nwater according to the water mask.',
          },
          {
            value: 3,
            description: 'Unclassified water: not classified because of missing\ndata but water according to the water mask.',
          },
          {
            value: 4,
            description: |||
              Classified sea ice: classified as snow/ice but water
              mask says it is water and less than 100m elevation, switched to
              water.
            |||,
          },
          {
            value: 5,
            description: 'Misclassified water: classified as water but water mask\nsays it is land, switched to secondary label.',
          },
          {
            value: 6,
            description: |||
              Omitted snow/ice: land according to the water mask that
              was classified as something other than snow but with a maximum annual
              temperature below 1&deg;C, relabeled as snow/ice.
            |||,
          },
          {
            value: 7,
            description: |||
              Misclassified snow/ice: land according to the water mask
              that was classified as snow but with a minimum annual temperature
              greater than 1&deg;C, relabeled as barren.
            |||,
          },
          {
            value: 8,
            description: 'Backfilled label: missing label from stabilization,\nfilled with the pre-stabilized result.',
          },
          {
            value: 9,
            description: 'Forest type changed: climate-based change to forest class.',
          },
        ],
      },
      {
        name: 'LW',
        description: 'Binary land (class 2) / water (class 1) mask derived from MOD44W',
        'gee:classes': [
          {
            value: 1,
            color: '1c0dff',
            description: 'Water',
          },
          {
            value: 2,
            color: 'f9ffa4',
            description: 'Land,',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'IGBP Land Cover',
        lookat: {lon: 6.746, lat: 46.529, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              17.0,
            ],
            palette: [
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
              '1c0dff',
            ],
            bands: [
              'LC_Type1',
            ],
          },
        },
      },
    ],
    LC_Prop1_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    LC_Prop2_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    LC_Prop3_Assessment: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
