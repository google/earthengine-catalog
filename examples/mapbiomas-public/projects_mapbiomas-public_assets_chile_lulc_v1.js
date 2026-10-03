/**
  MapBiomas Chile - Land Use and Land Cover V2
*/

var assetPath = 'projects/mapbiomas-public/assets/chile/lulc/v1';

var year = 2024;
var version = 'v1';
var collectionId = 2;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 67,
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
};

Map.addLayer(collection, visParams, 'MapBiomas Chile LULC ' + year);
Map.centerObject(collection, 4);
