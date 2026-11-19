/**
  MapBiomas Paraguay - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/paraguay/lulc/v1';

var year = 2025;
var version = 'v1';
var collectionId = 3;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 33,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Woody Natural Vegetation
    '000000',  // [2] --
    '1f8d49',  // [3] Closed Natural Woodlands
    '7dc975',  // [4] Open Natural Woodlands
    '000000',  // [5] --
    '007785',  // [6] Flooded Natural Woodlands
    '000000',  // [7] --
    '000000',  // [8] --
    '7a6c00',  // [9] Forest Plantation
    'd6bc74',  // [10] Herbaceous Natural Vegetation
    '519799',  // [11] Flooded grasslands
    'd6bc74',  // [12] Grassland
    '000000',  // [13] --
    'ffefc3',  // [14] Agricultural Areas
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    '000000',  // [19] --
    '000000',  // [20] --
    '000000',  // [21] --
    'd4271e',  // [22] Non-vegetated area
    '000000',  // [23] --
    '000000',  // [24] --
    'db4d4f',  // [25] Other non-vegetated area
    '2532e4',  // [26] Water body
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    '000000',  // [29] --
    '000000',  // [30] --
    '000000',  // [31] --
    '000000',  // [32] --
    '2532e4',  // [33] River, lake or ocean
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Paraguay LULC ' + year);
Map.centerObject(collection, 7);
