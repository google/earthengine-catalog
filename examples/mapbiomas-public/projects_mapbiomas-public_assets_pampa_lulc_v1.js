/**
  MapBiomas Pampa - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/pampa/lulc/v1';

var year = 2024;

var images = ee.ImageCollection(assetPath);

// The asset keeps every published collection, so read the latest collection
// and the latest version of it from the collection itself.
var collectionId = images.aggregate_max('collection_id');
var version = ee.List(
  images.filter(ee.Filter.eq('collection_id', collectionId))
    .aggregate_array('version').distinct().sort()).get(-1);

var collection = images
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 33,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Natural woody vegetation
    '000000',  // [2] --
    '1f8d49',  // [3] Forest formation
    '7dc975',  // [4] Savanna formation
    '000000',  // [5] --
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '7a6c00',  // [9] Forest plantation
    'd6bc74',  // [10] Natural herbaceous vegetation
    '519799',  // [11] Wetland
    'd6bc74',  // [12] Grassland
    '000000',  // [13] --
    'ffefc3',  // [14] Farming
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'c27ba0',  // [18] Annual and perennial crop
    '000000',  // [19] --
    '000000',  // [20] --
    '000000',  // [21] --
    'd4271e',  // [22] Non-vegetated area
    '000000',  // [23] --
    '000000',  // [24] --
    '000000',  // [25] --
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

Map.addLayer(collection, visParams, 'MapBiomas Pampa LULC ' + year);
Map.centerObject(collection, 6);
