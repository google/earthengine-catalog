/**
  MapBiomas Democratic Republic of the Congo - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/drc/lulc/v1';

var year = 2025;
var version = 'v1';
var collectionId = 1;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 66,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest
    '000000',  // [2] --
    '1f8d49',  // [3] Forest Formation
    '7dc975',  // [4] Woodland
    '04381d',  // [5] Mangrove
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Forest Plantation
    'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
    '000000',  // [11] --
    '000000',  // [12] --
    '000000',  // [13] --
    'ffefc3',  // [14] Farming
    '000000',  // [15] --
    '000000',  // [16] --
    '000000',  // [17] --
    '000000',  // [18] --
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Pasture and Agriculture
    'd4271e',  // [22] Non Vegetated Area
    '000000',  // [23] --
    'd4271e',  // [24] Urban Area
    'db4d4f',  // [25] Other non Vegetated Area
    '2532e4',  // [26] Water
    '000000',  // [27] --
    '000000',  // [28] --
    '000000',  // [29] --
    '000000',  // [30] --
    '000000',  // [31] --
    '000000',  // [32] --
    '2532e4',  // [33] River, Lake, and Ocean
    '000000',  // [34] --
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
    'a89358',  // [66] Shrubland
  ],
};

// Kisangani region - Congo Basin rainforest and river
var region = ee.Geometry.Point([25.2, 0.5]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Democratic Republic of the Congo LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
