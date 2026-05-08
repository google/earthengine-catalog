/**
  MapBiomas Ecuador - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/ecuador/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 82,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Natural forest
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '7dc975',  // [4] Open forest
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Silviculture
    'd6bc74',  // [10] Non-forest natural formation
    '519799',  // [11] Non forest wetland
    'd6bc74',  // [12] Grassland
    'd89f5c',  // [13] Other non-forest natural formation
    'ffefc3',  // [14] Farming and silviculture
    '000000',  // [15] --
    '000000',  // [16] --
    '000000',  // [17] --
    '000000',  // [18] --
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of uses
    'd4271e',  // [22] Non-vegetated area
    'ffa07a',  // [23] Beach, dune and sand spot
    'd4271e',  // [24] Urban infrastructure
    'db4d4f',  // [25] Other anthropic non-vegetated area
    '2532e4',  // [26] Water
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky outcrop
    '9c0027',  // [30] Mining
    '091077',  // [31] Aquaculture
    '000000',  // [32] --
    '2532e4',  // [33] River, lake and ocean
    '93dfe6',  // [34] Glacier
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
    'e97a7a',  // [68] Other natural non-vegetated area
    '000000',  // [69] --
    '000000',  // [70] --
    '000000',  // [71] --
    '000000',  // [72] --
    '000000',  // [73] --
    'be83f7',  // [74] Banana
    '000000',  // [75] --
    '000000',  // [76] --
    '000000',  // [77] --
    '000000',  // [78] --
    '000000',  // [79] --
    '000000',  // [80] --
    'dfeb62',  // [81] Andean Herbaceous and Shrubby Vegetation
    '6fc179',  // [82] Flooded Andean Herbaceous
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Ecuador LULC ' + year);
Map.centerObject(collection, 7);
