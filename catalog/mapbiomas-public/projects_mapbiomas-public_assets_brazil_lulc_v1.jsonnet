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

    Images in this collection follow the naming format:

    ee.ImageCollection('projects/mapbiomas-public/assets/brazil/lulc/v1')

    Each image contains one band named classification, representing the land cover classification for that specific year, version and collection id.

    For more information, classification legend, methodology, and accuracy assessments, visit the [MapBiomas website](https://mapbiomas.org/en).

    It is recommended to consult the classification legend to interpret the class values.
    Note that MapBiomas provides discrete classification maps, not probabilities.
    These maps are most appropriate for map transitions, time series analysis, and land policy monitoring applications.

  |||,

  'gee:categories': [
    'landuse-landcover',
  ],

  keywords: [
    'agriculture',
    'forest-biomass',
    'surface-ground-water',
    'landcover',
    'landuse',
    'landsat',
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
    '2024-12-31T00:00:00Z'
  ),

  summaries: {

    gsd: [30],

    'eo:bands': [
      {
        name: 'classification',
        description: 'Land use and land cover classification, with integer values corresponding to MapBiomas legend classes.',
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
            max: [75],
            palette: [
              'ffffff',  // [0] Not Observed
              '32a65e',  // [1] --
              '32a65e',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '7dc975',  // [4] Savanna Formation
              '04381d',  // [5] Mangrove
              '026975',  // [6] Floodable Forest
              '000000',  // [7] --
              '000000',  // [8] --
              '7a6c00',  // [9] Forest Plantation
              'ad975a',  // [10] --
              '519799',  // [11] Wetland
              'd6bc74',  // [12] Grassland
              'd89f5c',  // [13] Other Non Forest Formations
              'FFFFB2',  // [14] --
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'f5b3c8',  // [18] Agriculture
              'C27BA0',  // [19] --
              'db7093',  // [20] Sugar Cane
              'ffefc3',  // [21] Mosaic of Uses
              'db4d4f',  // [22] Non vegetated area
              'ffa07a',  // [23] Beach, Dune and Sand Spot
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other Non Vegetated Areas
              '0000FF',  // [26] --
              '000000',  // [27] --
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky Outcrop
              '9c0027',  // [30] Mining
              '091077',  // [31] Aquaculture
              'fc8114',  // [32] Hypersaline Tidal Flat
              '2532e4',  // [33] Rivers, Lakes and Ocean
              '93dfe6',  // [34] Glacier
              '9065d0',  // [35] --
              'd082de',  // [36] --
              '000000',  // [37] --
              '000000',  // [38] --
              'f5b3c8',  // [39] Soybean
              'c71585',  // [40] Rice
              'f54ca9',  // [41] Other Temporary Crops
              'cca0d4',  // [42] --
              'dbd26b',  // [43] --
              '807a40',  // [44] --
              'e04cfa',  // [45] --
              'd68fe2',  // [46] Coffee
              '9932cc',  // [47] Citrus
              'e6ccff',  // [48] Other Perennial Crops
              '02d659',  // [49] Wooded Sandbank Vegetation
              'ad5100',  // [50] Herbaceous Sandbank Vegetation
              '000000',  // [51] --
              '000000',  // [52] --
              '000000',  // [53] --
              '000000',  // [54] --
              '000000',  // [55] --
              '000000',  // [56] --
              'CC66FF',  // [57] --
              'FF6666',  // [58] --
              '006400',  // [59] --
              '8d9e8b',  // [60] --
              'f5d5d5',  // [61] Salt Flats
              'ff69b4',  // [62] Cotton
              'ebf8b5',  // [63] --
              '000000',  // [64] --
              '000000',  // [65] --
              '91ff36',  // [66] --
              '7dc975',  // [67] --
              'e97a7a',  // [68] --
              '0fffe3',  // [69] Coral Reefs
              '000000',  // [70] --
              '000000',  // [71] --
              '000000',  // [72] --
              '000000',  // [73] --
              '000000',  // [74] --
              'c12100',  // [75] Photovoltaic Power Plant
              
            ],
          },
        },
      },
    ],

  },

  'sci:doi': '10.3390/rs12172735',
  'sci:citation': |||
    Souza et al. (2020) – Reconstructing Three Decades of Land Use and Land Cover Changes in Brazilian Biomes with Landsat Archive and Earth Engine – Remote Sensing, 
    Volume 12, Issue 17, 10.3390/rs12172735.

    [doi:10.3390/rs12172735](https://doi.org/10.3390/rs12172735)

  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

  'gee:status': 'beta',

  'gee:type': ee_const.gee_type.image,

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
