local id = 'projects/mapbiomas-public/assets/atlantic_forest/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Atlantic Forest V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Atlantic Forest is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    The Atlantic Forest is a transboundary biome shared by Brazil, Paraguay and
    Argentina, running along the Brazilian coast and inland to the Parana basin.
    Centuries of occupation left a fragmented landscape, and the legend is
    detailed on the uses that replaced the forest: coffee, tea and other perennial
    crops, annual crops, pasture and mosaic of uses, alongside coastal classes
    such as mangrove, hypersaline tidal flat and sandbank vegetation.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://bosqueatlantico.mapbiomas.org/en).
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
    -57.9838,
    -33.752,
    -34.7937,
    -2.746,
    '1985-01-01T00:00:00Z',
    '2023-12-31T00:00:00Z'
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
          corresponding to MapBiomas Atlantic Forest legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest'},
          {value: 3,  color: '1f8d49', description: 'Forest Formation'},
          {value: 4,  color: '7dc975', description: 'Savanna Formation'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 9,  color: '7a5900', description: 'Forest Plantation'},
          {value: 10, color: 'd6bc74', description: 'Non Forest Natural Formation'},
          {value: 11, color: '519799', description: 'Flooded grasslands'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 13, color: 'd89f5c', description: 'Other non Forest Formations'},
          {value: 14, color: 'ffefc3', description: 'Farming'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 19, color: 'c27ba0', description: 'Annual Crops'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of Uses'},
          {value: 22, color: 'd4271e', description: 'Non vegetated area'},
          {value: 26, color: '2532e4', description: 'Water'},
          {value: 27, color: 'ffffff', description: 'Not Observed'},
          {value: 29, color: 'ffaa5f', description: 'Rocky Outcrop'},
          {value: 31, color: '091077', description: 'Aquaculture'},
          {value: 32, color: 'fc8114', description: 'Hypersaline Tidal Flat'},
          {value: 33, color: '2532e4', description: 'River, Lake and Ocean'},
          {value: 36, color: 'd082de', description: 'Perennial Crop'},
          {value: 46, color: 'd68fe2', description: 'Coffee'},
          {value: 48, color: 'e6ccff', description: 'Other Perennial Crops'},
          {value: 49, color: '02d659', description: 'Wooded Sandbank Vegetation'},
          {value: 50, color: 'ad5100', description: 'Herbaceous Sandbank Vegetation'},
          {value: 65, color: 'b9158a', description: 'Tea'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Atlantic Forest',
        lookat: {lon: -45.0, lat: -20.0, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [65],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '7dc975',  // [4] Savanna Formation
              '04381d',  // [5] Mangrove
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest Plantation
              'd6bc74',  // [10] Non Forest Natural Formation
              '519799',  // [11] Flooded grasslands
              'd6bc74',  // [12] Grassland
              'd89f5c',  // [13] Other non Forest Formations
              'ffefc3',  // [14] Farming
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              'c27ba0',  // [19] Annual Crops
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of Uses
              'd4271e',  // [22] Non vegetated area
              '000000',  // [23] --
              '000000',  // [24] --
              '000000',  // [25] --
              '2532e4',  // [26] Water
              'ffffff',  // [27] Not Observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky Outcrop
              '000000',  // [30] --
              '091077',  // [31] Aquaculture
              'fc8114',  // [32] Hypersaline Tidal Flat
              '2532e4',  // [33] River, Lake and Ocean
              '000000',  // [34] --
              '000000',  // [35] --
              'd082de',  // [36] Perennial Crop
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              '000000',  // [40] --
              '000000',  // [41] --
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '000000',  // [45] --
              'd68fe2',  // [46] Coffee
              '000000',  // [47] --
              'e6ccff',  // [48] Other Perennial Crops
              '02d659',  // [49] Wooded Sandbank Vegetation
              'ad5100',  // [50] Herbaceous Sandbank Vegetation
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
              'b9158a',  // [65] Tea
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
