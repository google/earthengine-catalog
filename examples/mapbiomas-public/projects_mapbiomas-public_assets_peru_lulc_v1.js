/**
  MapBiomas Peru - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/peru/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 72,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest Formation
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '7dc975',  // [4] Dry Forest
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded Forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Planted Forest
    'd6bc74',  // [10] Non-forest Formation
    '519799',  // [11] Swamp or Flooded Grassland
    'd6bc74',  // [12] Grasslands/Herbaceous
    'd89f5c',  // [13] Other Non-forest Formations
    'ffefc3',  // [14] Agricultural Area
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of Agriculture and Pasture
    'd4271e',  // [22] Non-vegetated Area
    'ffa07a',  // [23] Beach
    'd4271e',  // [24] Infrastructure
    'db4d4f',  // [25] Other Non-vegetated Area
    '2532e4',  // [26] Water Body
    'ffffff',  // [27] Not Observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky Outcrop
    '9c0027',  // [30] Mining
    '091077',  // [31] Aquaculture
    'fc8114',  // [32] Coastal Salt Flat
    '2532e4',  // [33] River, Lake or Ocean
    '93dfe6',  // [34] Glacier
    '9065d0',  // [35] Oil Palm
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
    'f5d5d5',  // [61] Salt Flat
    '000000',  // [62] --
    '000000',  // [63] --
    '000000',  // [64] --
    '000000',  // [65] --
    'a89358',  // [66] Scrubland
    '000000',  // [67] --
    'e97a7a',  // [68] Other Natural Non-vegetated Area
    '000000',  // [69] --
    'be9e00',  // [70] Fog Oasis
    '000000',  // [71] --
    '910046',  // [72] Other Crops
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Peru LULC ' + year);
Map.centerObject(collection, 5);
