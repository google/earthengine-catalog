local id = 'projects/mapbiomas-public/assets/venezuela/lulc/v1';

local subdir = 'mapbiomas-public';

local version = '1.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,

  title: 'MapBiomas Land Use and Land Cover - Venezuela V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Venezuela is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at 30-meter resolution covering the period from 1985 to 2024.

    Venezuela's territory spans several major regions, including the Amazon
    rainforest, the Orinoco Llanos (plains), the Andean highlands, the Orinoco River
    Delta, and the Caribbean coast. This diversity is reflected in the classification
    legend, which includes classes specific to Venezuelan ecosystems such as wooded
    savanna, hypersaline tidal flat, xerophytic grassland/shrubland, and Andean
    herbaceous/shrubby vegetation.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses automated decision trees trained with
    reference samples and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://mapbiomas.org/en).
  |||,

  'gee:categories': ['landuse-landcover'],

  keywords: [
    'landsat_derived',
  ],

  providers: [
    ee.producer_provider('MapBiomas', 'https://mapbiomas.org'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(
    -73.38,
    0.65,
    -59.80,
    12.20,
    '1985-01-01T00:00:00Z',
    '2024-12-31T00:00:00Z'
  ),

  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: |||
          Year of the land use and land cover classification.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'version',
        description: |||
          Version of the land use and land cover classification.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'collection_id',
        description: |||
          Collection identifier of the land use and land cover classification.
        |||,
        type: ee_const.var_type.double,
      },
    ],

    gsd: [30],

    'eo:bands': [
      {
        name: 'classification',
        description: |||
          Land use and land cover classification, with integer values
          corresponding to MapBiomas Venezuela legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest Formations'},
          {value: 3,  color: '1f8d49', description: 'Forest'},
          {value: 4,  color: '7dc975', description: 'Wooded Savanna'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 6,  color: '026975', description: 'Flooded Forest'},
          {value: 9,  color: '7a6c00', description: 'Forest Plantation'},
          {value: 10, color: 'd6bc74', description: 'Grasslands and Shrublands'},
          {value: 11, color: '519799', description: 'Flooded Grassland/Shrubland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 13, color: 'd89f5c', description: 'Other Non-forest Natural Formations'},
          {value: 14, color: 'ffefc3', description: 'Agricultural Areas'},
          {value: 15, color: 'edde8e', description: 'Pasture/Fallow Lands'},
          {value: 18, color: 'e974ed', description: 'Agriculture/Fallow Lands'},
          {value: 21, color: 'ffefc3', description: 'Cropland/Pasture/Fallow Lands'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated Areas'},
          {value: 23, color: 'ffa07a', description: 'Beach or Dune'},
          {value: 24, color: 'd4271e', description: 'Urban'},
          {value: 25, color: 'db4d4f', description: 'Other Non-vegetated Anthropic Areas'},
          {value: 26, color: '2532e4', description: 'Water Bodies'},
          {value: 27, color: 'ffffff', description: 'Not Observed'},
          {value: 29, color: 'ffaa5f', description: 'Rocky Outcrop'},
          {value: 30, color: '9c0027', description: 'Mining'},
          {value: 31, color: '091077', description: 'Aquaculture'},
          {value: 32, color: 'fc8114', description: 'Hypersaline Tidal Flat'},
          {value: 33, color: '2532e4', description: 'River, lake or ocean'},
          {value: 34, color: '93dfe6', description: 'Glacier'},
          {value: 50, color: 'ad5100', description: 'Xerophytic Grassland/Shrubland'},
          {value: 66, color: 'a89358', description: 'Shrubland'},
          {value: 68, color: 'e97a7a', description: 'Other Non-vegetated Natural Areas'},
          {value: 81, color: 'dfeb62', description: 'Andean Herbaceous/Shrubby Vegetation'},
          {value: 82, color: '6fc179', description: 'Flooded Andean Herbaceous/Shrubby Vegetation'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Venezuela',
        lookat: {lon: -66.5, lat: 7.5, zoom: 6},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [82],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest Formations
              '000000',  // [2] --
              '1f8d49',  // [3] Forest
              '7dc975',  // [4] Wooded Savanna
              '04381d',  // [5] Mangrove
              '026975',  // [6] Flooded Forest
              '000000',  // [7] --
              '000000',  // [8] --
              '7a6c00',  // [9] Forest Plantation
              'd6bc74',  // [10] Grasslands and Shrublands
              '519799',  // [11] Flooded Grassland/Shrubland
              'd6bc74',  // [12] Grassland
              'd89f5c',  // [13] Other Non-forest Natural Formations
              'ffefc3',  // [14] Agricultural Areas
              'edde8e',  // [15] Pasture/Fallow Lands
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture/Fallow Lands
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Cropland/Pasture/Fallow Lands
              'd4271e',  // [22] Non-vegetated Areas
              'ffa07a',  // [23] Beach or Dune
              'd4271e',  // [24] Urban
              'db4d4f',  // [25] Other Non-vegetated Anthropic Areas
              '2532e4',  // [26] Water Bodies
              'ffffff',  // [27] Not Observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky Outcrop
              '9c0027',  // [30] Mining
              '091077',  // [31] Aquaculture
              'fc8114',  // [32] Hypersaline Tidal Flat
              '2532e4',  // [33] River, lake or ocean
              '93dfe6',  // [34] Glacier
              '000000',  // [35] --
              '000000',  // [36] --
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              '000000',  // [40] --
              '000000',  // [41] --
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '000000',  // [45] --
              '000000',  // [46] --
              '000000',  // [47] --
              '000000',  // [48] --
              '000000',  // [49] --
              'ad5100',  // [50] Xerophytic Grassland/Shrubland
              '000000',  // [51] --
              '000000',  // [52] --
              '000000',  // [53] --
              '000000',  // [54] --
              '000000',  // [55] --
              '000000',  // [56] --
              '000000',  // [57] --
              '000000',  // [58] --
              '000000',  // [59] --
              '000000',  // [60] --
              '000000',  // [61] --
              '000000',  // [62] --
              '000000',  // [63] --
              '000000',  // [64] --
              '000000',  // [65] --
              'a89358',  // [66] Shrubland
              '000000',  // [67] --
              'e97a7a',  // [68] Other Non-vegetated Natural Areas
              '000000',  // [69] --
              '000000',  // [70] --
              '000000',  // [71] --
              '000000',  // [72] --
              '000000',  // [73] --
              '000000',  // [74] --
              '000000',  // [75] --
              '000000',  // [76] --
              '000000',  // [77] --
              '000000',  // [78] --
              '000000',  // [79] --
              '000000',  // [80] --
              'dfeb62',  // [81] Andean Herbaceous/Shrubby Vegetation
              '6fc179',  // [82] Flooded Andean Herbaceous/Shrubby Vegetation
            ],
          },
        },
      },
    ],
  },

  'sci:doi': '10.3390/rs12172735',
  'sci:citation': |||
    Souza et al. (2020) - Reconstructing Three Decades of Land Use and Land Cover
    Changes in Brazilian Biomes with Landsat Archive and Earth Engine - Remote Sensing,
    Volume 12, Issue 17, 10.3390/rs12172735.

    [doi:10.3390/rs12172735](https://doi.org/10.3390/rs12172735)
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

  'gee:status': 'beta',

  'gee:type': ee_const.gee_type.image_collection,

  license: license.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
