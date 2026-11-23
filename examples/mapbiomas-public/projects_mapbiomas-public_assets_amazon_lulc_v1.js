/**
  MapBiomas Amazon - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/amazon/lulc/v1';

var year = 2023;
var version = 'v1';
var collectionId = 6;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 68,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Natural forest
    '000000',  // [2] --
    '1f8d49',  // [3] Forest formation
    '7dc975',  // [4] Savanna formation / Open forest
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Silviculture
    'd6bc74',  // [10] Non-forest natural formation
    '519799',  // [11] Flooded grassland / Shrubland
    'd6bc74',  // [12] Grassland
    'd89f5c',  // [13] Other non-forest natural formation
    'ffefc3',  // [14] Farming and silviculture
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
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
    'ffaa5f',  // [29] Rock outcrop
    '9c0027',  // [30] Mining
    '000000',  // [31] --
    '000000',  // [32] --
    '2532e4',  // [33] River, lake and ocean
    '93dfe6',  // [34] Glacier
    '9065d0',  // [35] Oil palm
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
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Amazon LULC ' + year);
Map.centerObject(collection, 5);
