local id = 'projects/mapbiomas-public/assets/ecuador/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Ecuador V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Ecuador is produced annually
    by the MapBiomas Project using Landsat satellite imagery and machine learning
    classification techniques. The dataset provides consistent annual land cover maps
    at 30-meter resolution covering the period from 1985 to 2024.

    Ecuador's territory encompasses four distinct natural regions: the Amazon (Oriente),
    the Andes highlands (Sierra), the Pacific Coast (Costa), and the Galapagos Islands.
    This geographic diversity is reflected in the classification legend, which includes
    classes specific to Ecuadorian ecosystems such as Andean herbaceous and shrubby
    vegetation, flooded Andean herbaceous, mangrove, and banana plantations.

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
    -81.1555,
    -5.1216,
    -75.1741,
    2.4547,
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
          corresponding to MapBiomas Ecuador legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Natural forest'},
          {value: 3,  color: '1f8d49', description: 'Forest'},
          {value: 4,  color: '7dc975', description: 'Open forest'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 6,  color: '026975', description: 'Flooded forest'},
          {value: 9,  color: '7a5900', description: 'Silviculture'},
          {value: 10, color: 'd6bc74', description: 'Non-forest natural formation'},
          {value: 11, color: '519799', description: 'Non forest wetland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 13, color: 'd89f5c', description: 'Other non-forest natural formation'},
          {value: 14, color: 'ffefc3', description: 'Farming and silviculture'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of uses'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 23, color: 'ffa07a', description: 'Beach, dune and sand spot'},
          {value: 24, color: 'd4271e', description: 'Urban infrastructure'},
          {value: 25, color: 'db4d4f', description: 'Other anthropic non-vegetated area'},
          {value: 26, color: '2532e4', description: 'Water'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 29, color: 'ffaa5f', description: 'Rocky outcrop'},
          {value: 30, color: '9c0027', description: 'Mining'},
          {value: 31, color: '091077', description: 'Aquaculture'},
          {value: 33, color: '2532e4', description: 'River, lake and ocean'},
          {value: 34, color: '93dfe6', description: 'Glacier'},
          {value: 68, color: 'e97a7a', description: 'Other natural non-vegetated area'},
          {value: 74, color: 'be83f7', description: 'Banana'},
          {value: 81, color: 'dfeb62', description: 'Andean Herbaceous and Shrubby Vegetation'},
          {value: 82, color: '6fc179', description: 'Flooded Andean Herbaceous'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Ecuador',
        lookat: {lon: -78.2, lat: -1.3, zoom: 7},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [82],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Natural forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest
              '7dc975',  // [4] Open forest
              '04381d',  // [5] Mangrove
              '026975',  // [6] Flooded forest
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Silviculture
              'd6bc74',  // [10] Non-forest natural formation
              '519799',  // [11] Non forest wetland
              'd6bc74',  // [12] Grassland
              'd89f5c',  // [13] Other non-forest natural formation
              'ffefc3',  // [14] Farming and silviculture
              '000000',  // [15] --
              '000000',  // [16] --
              '000000',  // [17] --
              '000000',  // [18] --
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of uses
              'd4271e',  // [22] Non-vegetated area
              'ffa07a',  // [23] Beach, dune and sand spot
              'd4271e',  // [24] Urban infrastructure
              'db4d4f',  // [25] Other anthropic non-vegetated area
              '2532e4',  // [26] Water
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky outcrop
              '9c0027',  // [30] Mining
              '091077',  // [31] Aquaculture
              '000000',  // [32] --
              '2532e4',  // [33] River, lake and ocean
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
              '000000',  // [50] --
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
              '000000',  // [66] --
              '000000',  // [67] --
              'e97a7a',  // [68] Other natural non-vegetated area
              '000000',  // [69] --
              '000000',  // [70] --
              '000000',  // [71] --
              '000000',  // [72] --
              '000000',  // [73] --
              'be83f7',  // [74] Banana
              '000000',  // [75] --
              '000000',  // [76] --
              '000000',  // [77] --
              '000000',  // [78] --
              '000000',  // [79] --
              '000000',  // [80] --
              'dfeb62',  // [81] Andean Herbaceous and Shrubby Vegetation
              '6fc179',  // [82] Flooded Andean Herbaceous
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
