local id = 'projects/mapbiomas-public/assets/peru/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Peru V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Peru is produced annually
    by the MapBiomas Project using Landsat satellite imagery and machine learning
    classification techniques. The dataset provides consistent annual land cover maps
    at a 30-meter resolution.

    Peru's territory spans the Amazon rainforest, the Andean highlands, the Pacific
    coastal desert, and the Equatorial Dry Forest. This geographic diversity is
    reflected in the classification legend, which includes classes specific to
    Peruvian ecosystems such as dry forest, fog oasis, coastal salt flat, flooded
    forest, oil palm, Andean herbaceous and floodable vegetation, and glaciers.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas Peru website](https://peru.mapbiomas.org/en).
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
    -81.41,
    -18.35,
    -68.65,
    -0.03,
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
          corresponding to MapBiomas Peru legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest formation'},
          {value: 3,  color: '1f8d49', description: 'Forest'},
          {value: 4,  color: '7dc975', description: 'Dry forest'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 6,  color: '026975', description: 'Flooded forest'},
          {value: 9,  color: '7a5900', description: 'Planted forest'},
          {value: 10, color: 'd6bc74', description: 'Non-forest formation'},
          {value: 11, color: '519799', description: 'Swamp or flooded grassland'},
          {value: 12, color: 'd6bc74', description: 'Grassland / Herbaceous'},
          {value: 13, color: 'd89f5c', description: 'Other non-forest formations'},
          {value: 14, color: 'ffefc3', description: 'Agricultural area'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of agriculture and pasture'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 23, color: 'ffa07a', description: 'Beach'},
          {value: 24, color: 'd4271e', description: 'Urban infrastructure'},
          {value: 25, color: 'db4d4f', description: 'Other non vegetated area'},
          {value: 26, color: '2532e4', description: 'Water body'},
          {value: 27, color: 'bcbcbc', description: 'Not observed'},
          {value: 29, color: 'ffaa5f', description: 'Rocky outcrop'},
          {value: 30, color: '9c0027', description: 'Mining'},
          {value: 31, color: '091077', description: 'Aquaculture'},
          {value: 32, color: 'fc8114', description: 'Coastal salt flat'},
          {value: 33, color: '2532e4', description: 'River, lake or ocean'},
          {value: 34, color: '93dfe6', description: 'Glacier'},
          {value: 35, color: '9065d0', description: 'Oil palm'},
          {value: 40, color: 'c71585', description: 'Rice'},
          {value: 61, color: 'f5d5d5', description: 'Salt flat'},
          {value: 66, color: 'a89358', description: 'Scrubland'},
          {value: 68, color: 'e97a7a', description: 'Other natural non vegetated area'},
          {value: 70, color: 'be9e00', description: 'Fog oasis'},
          {value: 72, color: '910046', description: 'Other crops'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Peru',
        lookat: {lon: -75.0, lat: -9.5, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [72],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest formation
              '000000',  // [2] --
              '1f8d49',  // [3] Forest
              '7dc975',  // [4] Dry forest
              '04381d',  // [5] Mangrove
              '026975',  // [6] Flooded forest
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Planted forest
              'd6bc74',  // [10] Non-forest formation
              '519799',  // [11] Swamp or flooded grassland
              'd6bc74',  // [12] Grassland / Herbaceous
              'd89f5c',  // [13] Other non-forest formations
              'ffefc3',  // [14] Agricultural area
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of agriculture and pasture
              'd4271e',  // [22] Non-vegetated area
              'ffa07a',  // [23] Beach
              'd4271e',  // [24] Urban infrastructure
              'db4d4f',  // [25] Other non vegetated area
              '2532e4',  // [26] Water body
              'bcbcbc',  // [27] Not observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky outcrop
              '9c0027',  // [30] Mining
              '091077',  // [31] Aquaculture
              'fc8114',  // [32] Coastal salt flat
              '2532e4',  // [33] River, lake or ocean
              '93dfe6',  // [34] Glacier
              '9065d0',  // [35] Oil palm
              '000000',  // [36] --
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              'c71585',  // [40] Rice
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
              'f5d5d5',  // [61] Salt flat
              '000000',  // [62] --
              '000000',  // [63] --
              '000000',  // [64] --
              '000000',  // [65] --
              'a89358',  // [66] Scrubland
              '000000',  // [67] --
              'e97a7a',  // [68] Other natural non vegetated area
              '000000',  // [69] --
              'be9e00',  // [70] Fog oasis
              '000000',  // [71] --
              '910046',  // [72] Other crops
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
