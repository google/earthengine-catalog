/**
  MapBiomas Colombia - Land Use and Land Cover V2
*/

var assetPath = 'projects/mapbiomas-public/assets/colombia/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 82,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest formation
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '000000',  // [4] --
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Forest plantation
    'd6bc74',  // [10] Natural non forest formation
    '519799',  // [11] Wetland
    'd6bc74',  // [12] Grasslands/herbaceous
    'd89f5c',  // [13] Other non forest formation
    'ffefc3',  // [14] Agricultural and livestock area
    '000000',  // [15] --
    '000000',  // [16] --
    '000000',  // [17] --
    '000000',  // [18] --
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of agriculture and pasture
    'd4271e',  // [22] Non-vegetated area
    'ffa07a',  // [23] Beach, dune and sand spot
    'd4271e',  // [24] Infrastructure
    'db4d4f',  // [25] Other non-vegetated area
    '2532e4',  // [26] Water body
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky outcrop
    '9c0027',  // [30] Mining
    '091077',  // [31] Aquaculture
    'fc8114',  // [32] Hypersaline tidal flat
    '2532e4',  // [33] River, lake or ocean
    '93dfe6',  // [34] Glacier
    '9065d0',  // [35] Palm oil
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
    '02d659',  // [49] Wooded sand vegetation
    'ad5100',  // [50] Herbaceous sand vegetation
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
    'be83f7',  // [74] Banana (beta)
    'c12100',  // [75] Solar panel farm
    '000000',  // [76] --
    '000000',  // [77] --
    '000000',  // [78] --
    '000000',  // [79] --
    '000000',  // [80] --
    'dfeb62',  // [81] Andean Herbaceous and Shrubby Vegetation
    '6fc179',  // [82] Flooded Andean Herbaceous and Shrubby Vegetation
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Colombia LULC ' + year);
Map.centerObject(collection, 6);
