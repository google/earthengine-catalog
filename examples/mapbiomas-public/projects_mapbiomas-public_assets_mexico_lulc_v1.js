/**
  MapBiomas Mexico - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/mexico/lulc/v1';

var year = 2025;
var version = 'v1';
var collectionId = 1;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 89,
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
};

Map.addLayer(collection, visParams, 'MapBiomas Mexico LULC ' + year);
Map.centerObject(collection, 6);
