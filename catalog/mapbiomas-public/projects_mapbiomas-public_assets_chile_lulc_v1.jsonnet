local id = 'projects/mapbiomas-public/assets/chile/lulc/v1';

local subdir = 'mapbiomas-public';

local version = '2.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,

  title: 'MapBiomas Land Use and Land Cover - Chile V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Chile is produced annually
    by the MapBiomas Project using Landsat satellite imagery and machine learning
    classification techniques. The dataset provides consistent annual land cover maps
    at a 30-meter resolution.

    Chile's elongated territory spans more than 4,000 kilometers, encompassing the
    Atacama Desert in the north, the Central Valley, temperate forests, and Patagonia
    and Tierra del Fuego in the south. This geographic diversity is reflected in the
    classification legend, which includes classes specific to Chilean ecosystems such
    as dwarf forest, steppe, salt flat, and ice and snow.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses automated decision trees trained with
    reference samples and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://chile.mapbiomas.org/en).
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
    -75.64,
    -55.61,
    -66.96,
    -17.58,
    '1999-01-01T00:00:00Z',
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
          corresponding to MapBiomas Chile legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest formation'},
          {value: 3,  color: '1f8d49', description: 'Forest'},
          {value: 9,  color: '7a5900', description: 'Silviculture'},
          {value: 10, color: 'd6bc74', description: 'Natural non forest formation'},
          {value: 11, color: '519799', description: 'Wetland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Farming and silviculture'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 23, color: 'ffa07a', description: 'Beach, Dune and Sand Spot'},
          {value: 24, color: 'd4271e', description: 'Infrastructure'},
          {value: 25, color: 'db4d4f', description: 'Other non-vegetated area'},
          {value: 26, color: '2532e4', description: 'Water Bodies'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 29, color: 'ffaa5f', description: 'Rocky Outcrop'},
          {value: 33, color: '2532e4', description: 'River, lake or ocean'},
          {value: 34, color: '93dfe6', description: 'Ice and snow'},
          {value: 59, color: '1f8d49', description: 'Primary Forest'},
          {value: 60, color: '5cb85d', description: 'Secondary Forest'},
          {value: 61, color: 'f5d5d5', description: 'Salt Flat'},
          {value: 63, color: 'c7e0ab', description: 'Steppe'},
          {value: 66, color: 'a89358', description: 'Shrubland'},
          {value: 67, color: 'c8ffb4', description: 'Dwarf Forest'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Chile',
        lookat: {lon: -71.5, lat: -36.0, zoom: 4},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [67],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest formation
              '000000',  // [2] --
              '1f8d49',  // [3] Forest
              '000000',  // [4] --
              '000000',  // [5] --
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Silviculture
              'd6bc74',  // [10] Natural non forest formation
              '519799',  // [11] Wetland
              'd6bc74',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Farming and silviculture
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              '000000',  // [21] --
              'd4271e',  // [22] Non-vegetated area
              'ffa07a',  // [23] Beach, Dune and Sand Spot
              'd4271e',  // [24] Infrastructure
              'db4d4f',  // [25] Other non-vegetated area
              '2532e4',  // [26] Water Bodies
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rocky Outcrop
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, lake or ocean
              '93dfe6',  // [34] Ice and snow
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
              '1f8d49',  // [59] Primary Forest
              '5cb85d',  // [60] Secondary Forest
              'f5d5d5',  // [61] Salt Flat
              '000000',  // [62] --
              'c7e0ab',  // [63] Steppe
              '000000',  // [64] --
              '000000',  // [65] --
              'a89358',  // [66] Shrubland
              'c8ffb4',  // [67] Dwarf Forest
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
