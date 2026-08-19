local id = 'projects/mapbiomas-public/assets/argentina/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Argentina V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Argentina is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    Argentina's territory is home to a diverse range of ecosystems, from the
    grasslands of the Pampas region and the forests of the Gran Chaco and the
    Atlantic Forest to arid regions such as the Puna, the High Andes, and the
    Patagonian steppe, among other ecoregions. This diversity is reflected in the
    legend, which includes categories such as forests, shrublands, grasslands, urban
    areas, and floodplains.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses automated decision trees trained with
    reference samples, collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas Argentina website](https://argentina.mapbiomas.org).

    It is recommended to consult the classification legend to interpret the class
    values.
    Note that MapBiomas provides discrete classification maps, not probabilities.
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
    -73.42,
    -55.25,
    -53.63,
    -21.83,
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
          corresponding to MapBiomas Argentina legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forests'},
          {value: 3,  color: '1f8d49', description: 'Closed forests'},
          {value: 4,  color: '7dc975', description: 'Open forests'},
          {value: 6,  color: '026975', description: 'Flooded forests'},
          {value: 9,  color: '7a5900', description: 'Forest plantations'},
          {value: 10, color: 'd6bc74', description: 'Natural herbaceous and shrub vegetation'},
          {value: 11, color: '519799', description: 'Flooded grassland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Agricultural and livestock area'},
          {value: 15, color: 'edde8e', description: 'Pastures'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 19, color: 'c27ba0', description: 'Temporary crops'},
          {value: 21, color: 'ffefc3', description: 'Agriculture and pasture mosaic'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 24, color: 'd4271e', description: 'Urban areas'},
          {value: 25, color: 'db4d4f', description: 'Other non-vegetated areas'},
          {value: 26, color: '2532e4', description: 'Water bodies'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 33, color: '2532e4', description: 'Rivers, lakes or ocean'},
          {value: 34, color: '93dfe6', description: 'Ice and permanent snow'},
          {value: 36, color: 'd082de', description: 'Perennial crops'},
          {value: 63, color: 'c7e0ab', description: 'Shrub and herbaceous mosaics'},
          {value: 66, color: 'a89358', description: 'Closed shrublands'},
          {value: 73, color: '6fc179', description: 'Peatlands'},
          {value: 77, color: '86b074', description: 'Open shrublands'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Argentina',
        lookat: {lon: -64.0, lat: -38.5, zoom: 4},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [77],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forests
              '000000',  // [2] --
              '1f8d49',  // [3] Closed forests
              '7dc975',  // [4] Open forests
              '000000',  // [5] --
              '026975',  // [6] Flooded forests
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Forest plantations
              'd6bc74',  // [10] Natural herbaceous and shrub vegetation
              '519799',  // [11] Flooded grassland
              'd6bc74',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Agricultural and livestock area
              'edde8e',  // [15] Pastures
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              'c27ba0',  // [19] Temporary crops
              '000000',  // [20] --
              'ffefc3',  // [21] Agriculture and pasture mosaic
              'd4271e',  // [22] Non-vegetated area
              '000000',  // [23] --
              'd4271e',  // [24] Urban areas
              'db4d4f',  // [25] Other non-vegetated areas
              '2532e4',  // [26] Water bodies
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] Rivers, lakes or ocean
              '93dfe6',  // [34] Ice and permanent snow
              '000000',  // [35] --
              'd082de',  // [36] Perennial crops
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
              'c7e0ab',  // [63] Shrub and herbaceous mosaics
              '000000',  // [64] --
              '000000',  // [65] --
              'a89358',  // [66] Closed shrublands
              '000000',  // [67] --
              '000000',  // [68] --
              '000000',  // [69] --
              '000000',  // [70] --
              '000000',  // [71] --
              '000000',  // [72] --
              '6fc179',  // [73] Peatlands
              '000000',  // [74] --
              '000000',  // [75] --
              '000000',  // [76] --
              '86b074',  // [77] Open shrublands
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
