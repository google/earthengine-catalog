local id = 'projects/mapbiomas-public/assets/brazil/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Brazil V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Brazil is produced annually by the MapBiomas Project using Landsat satellite imagery and machine learning classification techniques.
    The dataset provides consistent, thematically detailed maps at 30-meter resolution, covering multiple decades and updated each year.

    Each image in the collection contains annual land cover classifications with pixel values representing categorical land cover classes, such as forest, agriculture, pasture, water bodies, and urban areas.
    The classification legend is standardized and maintained across all years, enabling multi-temporal analyses of land use change, deforestation, reforestation, and other landscape dynamics.

    The classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9 (OLI/TIRS) surface reflectance data, preprocessed and mosaicked to generate cloud-free composites for each year.
    The classification process includes automated decision trees trained with reference samples, along with manual validation by regional experts.

    Each image contains one band named "classification", representing the land cover classification for that specific year, version and collection id.

    For more information, classification legend, methodology, and accuracy assessments, visit the [MapBiomas website](https://brazil.mapbiomas.org/en).

    It is recommended to consult the classification legend to interpret the class values.
    Note that MapBiomas provides discrete classification maps, not probabilities.
    These maps are most appropriate for map transitions, time series analysis, and land policy monitoring applications.

  |||,

  'gee:categories': [
    'landuse-landcover'
  ],

  keywords: [
    'landsat_derived'
  ],

  providers: [
    ee.producer_provider('MapBiomas', 'https://mapbiomas.org'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(
    -74.00,
    -34.00,
    -34.70,
    5.45,
    '1985-01-01T00:00:00Z',
    '2025-12-31T00:00:00Z'
  ),

  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: |||
          Year of the land use and land cover classification.
        |||,
        type: ee_const.var_type.int
      },
      {
        name: 'version',
        description: |||
          Version of the land use and land cover classification.
        |||,
        type: ee_const.var_type.string
      },
      {
        name: 'collection_id',
        description: |||
          Collection identifier of the land use and land cover classification.
        |||,
        type: ee_const.var_type.double
      },
    ],
    gsd: [30],

    'eo:bands': [
      {
        name: 'classification',
        description: 'Land use and land cover classification, with integer values corresponding to MapBiomas legend classes.',
        'gee:classes': [
          { value: 1,  color: '1f8d49', description: 'Forest' },
          { value: 3,  color: '1f8d49', description: 'Forest Formation' },
          { value: 4,  color: '7dc975', description: 'Savanna Formation' },
          { value: 5,  color: '04381d', description: 'Mangrove' },
          { value: 6,  color: '007785', description: 'Flooded Forest' },
          { value: 7,  color: '228c70', description: 'Flooded Savanna (beta)' },
          { value: 9,  color: '7a5900', description: 'Silviculture' },
          { value: 10, color: 'd6bc74', description: 'Herbaceous and Shrubby Vegetation' },
          { value: 11, color: '519799', description: 'Flooded Grassland and Wetland' },
          { value: 12, color: 'd6bc74', description: 'Grassland Formation' },
          { value: 14, color: 'ffefc3', description: 'Agriculture and Livestock' },
          { value: 15, color: 'edde8e', description: 'Pasture' },
          { value: 18, color: 'e974ed', description: 'Agriculture' },
          { value: 19, color: 'c27ba0', description: 'Temporary Crop' },
          { value: 20, color: 'db7093', description: 'Sugarcane' },
          { value: 21, color: 'ffefc3', description: 'Mosaic of Uses' },
          { value: 22, color: 'd4271e', description: 'Non-vegetated Area' },
          { value: 23, color: 'ffa07a', description: 'Beach, Dune, and Sandbank' },
          { value: 24, color: 'd4271e', description: 'Urban Area' },
          { value: 25, color: 'db4d4f', description: 'Other Non-Vegetated Areas' },
          { value: 26, color: '2532e4', description: 'Water Body' },
          { value: 29, color: 'ad5100', description: 'Rocky Outcrop' },
          { value: 30, color: '9c0027', description: 'Mining' },
          { value: 31, color: '091077', description: 'Aquaculture' },
          { value: 32, color: 'fc8114', description: 'Hypersaline Flat' },
          { value: 33, color: '2532e4', description: 'River, Lake, and Ocean' },
          { value: 35, color: '9065d0', description: 'Oil Palm' },
          { value: 36, color: 'd082de', description: 'Perennial Crop' },
          { value: 39, color: 'f5b3c8', description: 'Soybean' },
          { value: 40, color: 'c71585', description: 'Rice' },
          { value: 41, color: 'f54ca9', description: 'Other Temporary Crops' },
          { value: 46, color: 'd68fe2', description: 'Coffee' },
          { value: 47, color: '9932cc', description: 'Citrus' },
          { value: 48, color: 'e6ccff', description: 'Other Perennial Crops' },
          { value: 49, color: '02d659', description: 'Arboreal Restinga' },
          { value: 50, color: 'ffaa5f', description: 'Herbaceous or Shrubby Restinga' },
          { value: 62, color: 'ff69b4', description: 'Cotton (beta)' },
          { value: 75, color: '757272', description: 'Photovoltaic Plant' },
          { value: 77, color: '86b074', description: 'Herbaceous-Shrub Formation' },
          { value: 84, color: '81dbbf', description: 'Salt Marsh (beta)' },
          { value: 91, color: '403d3e', description: 'Wind farm (beta)' },
        ]
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas',
        lookat: {
          lon: -54, 
          lat: -14, 
          zoom: 5
        },
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [91],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '7dc975',  // [4] Savanna Formation
              '04381d',  // [5] Mangrove
              '007785',  // [6] Flooded Forest
              '228c70',  // [7] Flooded Savanna (beta)
              '000000',  // [8] --
              '7a5900',  // [9] Silviculture
              'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
              '519799',  // [11] Flooded Grassland and Wetland
              'd6bc74',  // [12] Grassland Formation
              '000000',  // [13] --
              'ffefc3',  // [14] Agriculture and Livestock
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              'c27ba0',  // [19] Temporary Crop
              'db7093',  // [20] Sugarcane
              'ffefc3',  // [21] Mosaic of Uses
              'd4271e',  // [22] Non-vegetated Area
              'ffa07a',  // [23] Beach, Dune, and Sandbank
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other Non-Vegetated Areas
              '2532e4',  // [26] Water Body
              '000000',  // [27] --
              '000000',  // [28] --
              'ad5100',  // [29] Rocky Outcrop
              '9c0027',  // [30] Mining
              '091077',  // [31] Aquaculture
              'fc8114',  // [32] Hypersaline Flat
              '2532e4',  // [33] River, Lake, and Ocean
              '000000',  // [34] --
              '9065d0',  // [35] Oil Palm
              'd082de',  // [36] Perennial Crop
              '000000',  // [37] --
              '000000',  // [38] --
              'f5b3c8',  // [39] Soybean
              'c71585',  // [40] Rice
              'f54ca9',  // [41] Other Temporary Crops
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '000000',  // [45] --
              'd68fe2',  // [46] Coffee
              '9932cc',  // [47] Citrus
              'e6ccff',  // [48] Other Perennial Crops
              '02d659',  // [49] Arboreal Restinga
              'ffaa5f',  // [50] Herbaceous or Shrubby Restinga
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
              'ff69b4',  // [62] Cotton (beta)
              '000000',  // [63] --
              '000000',  // [64] --
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
              '757272',  // [75] Photovoltaic Plant
              '000000',  // [76] --
              '86b074',  // [77] Herbaceous-Shrub Formation
              '000000',  // [78] --
              '000000',  // [79] --
              '000000',  // [80] --
              '000000',  // [81] --
              '000000',  // [82] --
              '000000',  // [83] --
              '81dbbf',  // [84] Salt Marsh (beta)
              '000000',  // [85] --
              '000000',  // [86] --
              '000000',  // [87] --
              '000000',  // [88] --
              '000000',  // [89] --
              '000000',  // [90] --
              '403d3e',  // [91] Wind farm (beta)
            ],
          },
        },
      },
    ],

  },

  'sci:doi': '10.3390/rs12172735',
  'sci:citation': |||
    Souza et al. (2020) - Reconstructing Three Decades of Land Use and Land Cover Changes in Brazilian Biomes with Landsat Archive and Earth Engine - Remote Sensing,
    Volume 12, Issue 17, 10.3390/rs12172735.

    [doi:10.3390/rs12172735](https://doi.org/10.3390/rs12172735)

  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

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
