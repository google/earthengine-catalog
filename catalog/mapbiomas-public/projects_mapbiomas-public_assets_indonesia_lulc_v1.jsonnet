local id = 'projects/mapbiomas-public/assets/indonesia/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Indonesia V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Indonesia is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    Indonesia stretches across more than seventeen thousand islands, from Sumatra
    and Kalimantan to Papua, and holds some of the largest peat swamp forests and
    mangrove areas in the world alongside an expanding plantation economy. The
    classification legend reflects that landscape, with classes for peat swamp
    forest, mangrove, oil palm, pulpwood plantation, rice paddy, aquaculture and
    mining pit.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://indonesia.mapbiomas.org/en).
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
    94.9719,
    -11.9292,
    141.02,
    6.0768,
    '1988-01-01T00:00:00Z',
    '2025-12-31T00:00:00Z'
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
          corresponding to MapBiomas Indonesia legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest'},
          {value: 3,  color: '1f8d49', description: 'Forest Formation'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 9,  color: '7a6c00', description: 'Forest Plantation'},
          {value: 10, color: 'd6bc74', description: 'Non-Forest Natural Formation'},
          {value: 11, color: '519799', description: 'Wetland'},
          {value: 12, color: 'd6bc74', description: 'Savannah'},
          {value: 13, color: 'd89f5c', description: 'Other Natural Vegetation'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 21, color: 'ffefc3', description: 'Other Agriculture'},
          {value: 22, color: 'd4271e', description: 'Non-Vegetated Area'},
          {value: 24, color: 'd4271e', description: 'Urban Area'},
          {value: 25, color: 'db4d4f', description: 'Other Non-Vegetation'},
          {value: 26, color: '2532e4', description: 'Water Body'},
          {value: 27, color: 'ffffff', description: 'Not Observed'},
          {value: 30, color: '9c0027', description: 'Mining Pit'},
          {value: 31, color: '091077', description: 'Aquaculture'},
          {value: 33, color: '2532e4', description: 'River, Lake, Ocean'},
          {value: 35, color: '9065d0', description: 'Oil Palm'},
          {value: 40, color: 'f272c2', description: 'Rice Paddy'},
          {value: 46, color: 'eb7fa5', description: 'Coffee'},
          {value: 48, color: 'e6ccff', description: 'Perennial Crops'},
          {value: 49, color: 'b77671', description: 'Rubber'},
          {value: 64, color: '089767', description: 'Sago'},
          {value: 76, color: '2f7360', description: 'Peat Swamp Forest'},
          {value: 80, color: '7a5900', description: 'Timber Plantation'},
          {value: 92, color: 'd98a45', description: 'Rocky Surface'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Indonesia',
        lookat: {lon: 118.0, lat: -2.0, zoom: 4},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [92],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '000000',  // [4] --
              '04381d',  // [5] Mangrove
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a6c00',  // [9] Forest Plantation
              'd6bc74',  // [10] Non-Forest Natural Formation
              '519799',  // [11] Wetland
              'd6bc74',  // [12] Savannah
              'd89f5c',  // [13] Other Natural Vegetation
              '000000',  // [14] --
              '000000',  // [15] --
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Other Agriculture
              'd4271e',  // [22] Non-Vegetated Area
              '000000',  // [23] --
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other Non-Vegetation
              '2532e4',  // [26] Water Body
              'ffffff',  // [27] Not Observed
              '000000',  // [28] --
              '000000',  // [29] --
              '9c0027',  // [30] Mining Pit
              '091077',  // [31] Aquaculture
              '000000',  // [32] --
              '2532e4',  // [33] River, Lake, Ocean
              '000000',  // [34] --
              '9065d0',  // [35] Oil Palm
              '000000',  // [36] --
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              'f272c2',  // [40] Rice Paddy
              '000000',  // [41] --
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '000000',  // [45] --
              'eb7fa5',  // [46] Coffee
              '000000',  // [47] --
              'e6ccff',  // [48] Perennial Crops
              'b77671',  // [49] Rubber
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
              '089767',  // [64] Sago
              '000000',  // [65] --
              '000000',  // [66] --
              '000000',  // [67] --
              '000000',  // [68] --
              '000000',  // [69] --
              '000000',  // [70] --
              '000000',  // [71] --
              '000000',  // [72] --
              '000000',  // [73] --
              '000000',  // [74] --
              '000000',  // [75] --
              '2f7360',  // [76] Peat Swamp Forest
              '000000',  // [77] --
              '000000',  // [78] --
              '000000',  // [79] --
              '7a5900',  // [80] Timber Plantation
              '000000',  // [81] --
              '000000',  // [82] --
              '000000',  // [83] --
              '000000',  // [84] --
              '000000',  // [85] --
              '000000',  // [86] --
              '000000',  // [87] --
              '000000',  // [88] --
              '000000',  // [89] --
              '000000',  // [90] --
              '000000',  // [91] --
              'd98a45',  // [92] Rocky Surface
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
