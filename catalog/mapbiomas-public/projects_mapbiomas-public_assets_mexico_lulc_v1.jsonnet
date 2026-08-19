local id = 'projects/mapbiomas-public/assets/mexico/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Mexico V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Mexico is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    Mexico's territory spans temperate forests in the Sierra Madre ranges, the
    Chihuahuan and Sonoran deserts, tropical dry forests along the Pacific coast,
    tropical humid forests in the southeast, and the mangroves of both coastlines.
    This diversity is reflected in the classification legend, which includes
    classes specific to Mexican ecosystems such as temperate forest, tropical dry
    forest, tropical humid forest, savanna and natural grassland, shrublands, and
    ice and permanent snow.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://mexico.mapbiomas.org/en).
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
    -118.3653,
    14.5321,
    -86.7104,
    32.7187,
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
          corresponding to MapBiomas Mexico legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest'},
          {value: 3,  color: '1f8d49', description: 'Tropical humid forest'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 9,  color: '7a5900', description: 'Forest plantation'},
          {value: 10, color: 'd6bc74', description: 'Natural herbaceous and shrub vegetation'},
          {value: 11, color: 'a89358', description: 'Flooded'},
          {value: 14, color: 'ffefc3', description: 'Agricultural and livestock area'},
          {value: 15, color: 'edde8e', description: 'Cultivated grassland'},
          {value: 19, color: 'c27ba0', description: 'Annual crop'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of land uses'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 24, color: 'd4271e', description: 'Urban and built-up area'},
          {value: 25, color: 'db4d4f', description: 'Other non-vegetated areas'},
          {value: 26, color: '2532e4', description: 'Water body'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 33, color: '2532e4', description: 'River, lake or ocean'},
          {value: 34, color: '93dfe6', description: 'Ice and permanent snow'},
          {value: 36, color: 'd082de', description: 'Perennial crop'},
          {value: 45, color: '807a40', description: 'Savanna and natural grassland'},
          {value: 66, color: '519799', description: 'Shrublands'},
          {value: 88, color: '329c5a', description: 'Temperate forest'},
          {value: 89, color: '6bd46c', description: 'Tropical dry forest'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Mexico',
        lookat: {lon: -102.5, lat: 23.6, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [89],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Tropical humid forest
              '000000',  // [4] --
              '04381d',  // [5] Mangrove
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest plantation
              'd6bc74',  // [10] Natural herbaceous and shrub vegetation
              'a89358',  // [11] Flooded
              '000000',  // [12] --
              '000000',  // [13] --
              'ffefc3',  // [14] Agricultural and livestock area
              'edde8e',  // [15] Cultivated grassland
              '000000',  // [16] --
              '000000',  // [17] --
              '000000',  // [18] --
              'c27ba0',  // [19] Annual crop
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of land uses
              'd4271e',  // [22] Non-vegetated area
              '000000',  // [23] --
              'd4271e',  // [24] Urban and built-up area
              'db4d4f',  // [25] Other non-vegetated areas
              '2532e4',  // [26] Water body
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, lake or ocean
              '93dfe6',  // [34] Ice and permanent snow
              '000000',  // [35] --
              'd082de',  // [36] Perennial crop
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              '000000',  // [40] --
              '000000',  // [41] --
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '807a40',  // [45] Savanna and natural grassland
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
              '519799',  // [66] Shrublands
              '000000',  // [67] --
              '000000',  // [68] --
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
              '000000',  // [81] --
              '000000',  // [82] --
              '000000',  // [83] --
              '000000',  // [84] --
              '000000',  // [85] --
              '000000',  // [86] --
              '000000',  // [87] --
              '329c5a',  // [88] Temperate forest
              '6bd46c',  // [89] Tropical dry forest
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
