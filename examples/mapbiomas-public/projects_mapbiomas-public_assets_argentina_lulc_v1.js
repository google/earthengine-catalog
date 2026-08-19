/**
  MapBiomas Argentina - Land Use and Land Cover V3
*/

var assetPath = 'projects/mapbiomas-public/assets/argentina/lulc/v1';

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
  max: 77,
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
};

Map.addLayer(collection, visParams, 'MapBiomas Argentina LULC ' + year);
Map.centerObject(collection, 4);
