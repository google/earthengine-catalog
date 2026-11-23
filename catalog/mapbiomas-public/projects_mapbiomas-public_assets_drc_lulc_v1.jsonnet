local id = 'projects/mapbiomas-public/assets/drc/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Democratic Republic of the Congo V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Democratic Republic of the Congo is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    The Democratic Republic of the Congo holds the largest share of the Congo
    Basin, the second-largest tropical rainforest on the planet, framed by miombo
    woodlands to the south and a short Atlantic coastline with mangroves. The
    classification legend is compact and centered on that gradient, separating
    forest formation, woodland, mangrove and shrubland from farming and the
    non-vegetated classes.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

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
    12.2069,
    -13.456,
    31.306,
    5.3861,
    '2000-01-01T00:00:00Z',
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
          corresponding to MapBiomas Democratic Republic of the Congo legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest'},
          {value: 3,  color: '1f8d49', description: 'Forest Formation'},
          {value: 4,  color: '7dc975', description: 'Woodland'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 9,  color: '7a5900', description: 'Forest Plantation'},
          {value: 10, color: 'd6bc74', description: 'Herbaceous and Shrubby Vegetation'},
          {value: 14, color: 'ffefc3', description: 'Farming'},
          {value: 21, color: 'ffefc3', description: 'Pasture and Agriculture'},
          {value: 22, color: 'd4271e', description: 'Non Vegetated Area'},
          {value: 24, color: 'd4271e', description: 'Urban Area'},
          {value: 25, color: 'db4d4f', description: 'Other non Vegetated Area'},
          {value: 26, color: '2532e4', description: 'Water'},
          {value: 33, color: '2532e4', description: 'River, Lake, and Ocean'},
          {value: 66, color: 'a89358', description: 'Shrubland'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Democratic Republic of the Congo',
        lookat: {lon: 23.6, lat: -2.9, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [66],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '7dc975',  // [4] Woodland
              '04381d',  // [5] Mangrove
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest Plantation
              'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
              '000000',  // [11] --
              '000000',  // [12] --
              '000000',  // [13] --
              'ffefc3',  // [14] Farming
              '000000',  // [15] --
              '000000',  // [16] --
              '000000',  // [17] --
              '000000',  // [18] --
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Pasture and Agriculture
              'd4271e',  // [22] Non Vegetated Area
              '000000',  // [23] --
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other non Vegetated Area
              '2532e4',  // [26] Water
              '000000',  // [27] --
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, Lake, and Ocean
              '000000',  // [34] --
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
              'a89358',  // [66] Shrubland
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
