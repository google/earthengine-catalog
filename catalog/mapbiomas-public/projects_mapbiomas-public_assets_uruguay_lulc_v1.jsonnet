local id = 'projects/mapbiomas-public/assets/uruguay/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Uruguay V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Uruguay is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at 30-meter resolution covering the period from 1985 to 2024.

    Uruguay's territory lies almost entirely within the Pampa biome, dominated by
    natural grasslands and extensive livestock and agricultural land uses. This is
    reflected in a simpler classification legend than other MapBiomas countries,
    which includes specific classes for forest plantations, such as pinus and
    eucalyptus plantations.

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
    -58.44,
    -35.00,
    -53.07,
    -30.09,
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
          corresponding to MapBiomas Uruguay legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Natural Woody Vegetation'},
          {value: 3,  color: '1f8d49', description: 'Closed Forest and Closed Shrubland'},
          {value: 9,  color: '7a5900', description: 'Forest Plantation'},
          {value: 10, color: 'ccc87e', description: 'Natural Herbaceous Vegetation'},
          {value: 11, color: '519799', description: 'Wetland'},
          {value: 12, color: 'ccc87e', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Agricultural and Livestock Area'},
          {value: 15, color: 'fbf0ab', description: 'Pasture'},
          {value: 19, color: 'c27ba0', description: 'Agriculture'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated Area'},
          {value: 26, color: '2532e4', description: 'Water Body'},
          {value: 27, color: 'ffffff', description: 'Not Observed'},
          {value: 33, color: '2532e4', description: 'River, Lake or Ocean'},
          {value: 79, color: '67671c', description: 'Pinus Plantation'},
          {value: 80, color: '886827', description: 'Eucalyptus Plantation'},
          {value: 83, color: 'ab8231', description: 'Other Types of Forest Plantation'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Uruguay',
        lookat: {lon: -56.0, lat: -32.8, zoom: 7},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [83],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Natural Woody Vegetation
              '000000',  // [2] --
              '1f8d49',  // [3] Closed Forest and Closed Shrubland
              '000000',  // [4] --
              '000000',  // [5] --
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest Plantation
              'ccc87e',  // [10] Natural Herbaceous Vegetation
              '519799',  // [11] Wetland
              'ccc87e',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Agricultural and Livestock Area
              'fbf0ab',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              '000000',  // [18] --
              'c27ba0',  // [19] Agriculture
              '000000',  // [20] --
              '000000',  // [21] --
              'd4271e',  // [22] Non-vegetated Area
              '000000',  // [23] --
              '000000',  // [24] --
              '000000',  // [25] --
              '2532e4',  // [26] Water Body
              'ffffff',  // [27] Not Observed
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, Lake or Ocean
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
              '000000',  // [76] --
              '000000',  // [77] --
              '000000',  // [78] --
              '67671c',  // [79] Pinus Plantation
              '886827',  // [80] Eucalyptus Plantation
              '000000',  // [81] --
              '000000',  // [82] --
              'ab8231',  // [83] Other Types of Forest Plantation
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
