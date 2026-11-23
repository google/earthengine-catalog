local id = 'projects/mapbiomas-public/assets/chaco/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Chaco V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Chaco is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    The Gran Chaco is a transboundary dry forest and savanna biome shared by
    Argentina, Bolivia and Paraguay, and one of the most active deforestation
    frontiers in South America. The legend is built to track that change in
    detail, grading woodland by density from closed to open and sparse, doing the
    same for grassland, and separating single from multiple cropping.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://chaco.mapbiomas.org/en).
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
    -67.7201,
    -33.8686,
    -55.7623,
    -17.5406,
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
          corresponding to MapBiomas Chaco legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Natural wooded vegetation'},
          {value: 3,  color: '1f8d49', description: 'Closed woodland'},
          {value: 4,  color: '7dc975', description: 'Open woodland'},
          {value: 6,  color: '026975', description: 'Flooded woodland'},
          {value: 9,  color: '7a5900', description: 'Forest plantation'},
          {value: 10, color: 'd6bc74', description: 'Natural non-wooded vegetation'},
          {value: 11, color: '519799', description: 'Flooded Grassland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Agricultural and livestock areas'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 19, color: 'c27ba0', description: 'Annual Crops'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 23, color: 'ffa07a', description: 'Beach, Dune and Sand Spot'},
          {value: 24, color: 'd4271e', description: 'Urban Area'},
          {value: 25, color: 'db4d4f', description: 'Other non Vegetated Areas'},
          {value: 26, color: '2532e4', description: 'Water bodies'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 36, color: 'd082de', description: 'Shrub plantation'},
          {value: 42, color: 'a5b35b', description: 'Open Grassland'},
          {value: 43, color: 'c2d26b', description: 'Closed Grassland'},
          {value: 44, color: 'cbe286', description: 'Sparse Grassland'},
          {value: 45, color: '807a40', description: 'Sparse woodland'},
          {value: 57, color: 'f99fff', description: 'Single crop'},
          {value: 58, color: 'd84690', description: 'Multiple crop'},
          {value: 61, color: 'f5d5d5', description: 'Salt Flat'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Chaco',
        lookat: {lon: -61.5, lat: -25.5, zoom: 5},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [61],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Natural wooded vegetation
              '000000',  // [2] --
              '1f8d49',  // [3] Closed woodland
              '7dc975',  // [4] Open woodland
              '000000',  // [5] --
              '026975',  // [6] Flooded woodland
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest plantation
              'd6bc74',  // [10] Natural non-wooded vegetation
              '519799',  // [11] Flooded Grassland
              'd6bc74',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Agricultural and livestock areas
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              'c27ba0',  // [19] Annual Crops
              '000000',  // [20] --
              '000000',  // [21] --
              'd4271e',  // [22] Non-vegetated area
              'ffa07a',  // [23] Beach, Dune and Sand Spot
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other non Vegetated Areas
              '2532e4',  // [26] Water bodies
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '000000',  // [33] --
              '000000',  // [34] --
              '000000',  // [35] --
              'd082de',  // [36] Shrub plantation
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              '000000',  // [40] --
              '000000',  // [41] --
              'a5b35b',  // [42] Open Grassland
              'c2d26b',  // [43] Closed Grassland
              'cbe286',  // [44] Sparse Grassland
              '807a40',  // [45] Sparse woodland
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
              'f99fff',  // [57] Single crop
              'd84690',  // [58] Multiple crop
              '000000',  // [59] --
              '000000',  // [60] --
              'f5d5d5',  // [61] Salt Flat
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
