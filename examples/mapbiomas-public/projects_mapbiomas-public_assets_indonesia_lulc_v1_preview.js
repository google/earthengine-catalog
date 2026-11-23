/**
  MapBiomas Indonesia - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/indonesia/lulc/v1';

var year = 2025;
var version = 'v1';
var collectionId = 5;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 92,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest
    '000000',  // [2] --
    '1f8d49',  // [3] Forest Formation
    '000000',  // [4] --
    '04381d',  // [5] Mangrove
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '7a6c00',  // [9] Forest Plantation
    'd6bc74',  // [10] Non-Forest Natural Formation
    '519799',  // [11] Wetland
    'd6bc74',  // [12] Savannah
    'd89f5c',  // [13] Other Natural Vegetation
    '000000',  // [14] --
    '000000',  // [15] --
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Other Agriculture
    'd4271e',  // [22] Non-Vegetated Area
    '000000',  // [23] --
    'd4271e',  // [24] Urban Area
    'db4d4f',  // [25] Other Non-Vegetation
    '2532e4',  // [26] Water Body
    'ffffff',  // [27] Not Observed
    '000000',  // [28] --
    '000000',  // [29] --
    '9c0027',  // [30] Mining Pit
    '091077',  // [31] Aquaculture
    '000000',  // [32] --
    '2532e4',  // [33] River, Lake, Ocean
    '000000',  // [34] --
    '9065d0',  // [35] Oil Palm
    '000000',  // [36] --
    '000000',  // [37] --
    '000000',  // [38] --
    '000000',  // [39] --
    'f272c2',  // [40] Rice Paddy
    '000000',  // [41] --
    '000000',  // [42] --
    '000000',  // [43] --
    '000000',  // [44] --
    '000000',  // [45] --
    'eb7fa5',  // [46] Coffee
    '000000',  // [47] --
    'e6ccff',  // [48] Perennial Crops
    'b77671',  // [49] Rubber
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
    '089767',  // [64] Sago
    '000000',  // [65] --
    '000000',  // [66] --
    '000000',  // [67] --
    '000000',  // [68] --
    '000000',  // [69] --
    '000000',  // [70] --
    '000000',  // [71] --
    '000000',  // [72] --
    '000000',  // [73] --
    '000000',  // [74] --
    '000000',  // [75] --
    '2f7360',  // [76] Peat Swamp Forest
    '000000',  // [77] --
    '000000',  // [78] --
    '000000',  // [79] --
    '7a5900',  // [80] Timber Plantation
    '000000',  // [81] --
    '000000',  // [82] --
    '000000',  // [83] --
    '000000',  // [84] --
    '000000',  // [85] --
    '000000',  // [86] --
    '000000',  // [87] --
    '000000',  // [88] --
    '000000',  // [89] --
    '000000',  // [90] --
    '000000',  // [91] --
    'd98a45',  // [92] Rocky Surface
  ],
};

// Riau, Sumatra - oil palm, pulpwood plantation and peat swamp forest
var region = ee.Geometry.Point([101.5, 0.5]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Indonesia LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
