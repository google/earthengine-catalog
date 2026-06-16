/**
  MapBiomas Uruguay - Land Use and Land Cover V1 - Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/uruguay/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 83,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Natural Woody Vegetation
    '000000',  // [2] --
    '1f8d49',  // [3] Closed Forest and Closed Shrubland
    '000000',  // [4] --
    '000000',  // [5] --
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Forest Plantation
    'ccc87e',  // [10] Natural Herbaceous Vegetation
    '519799',  // [11] Wetland
    'ccc87e',  // [12] Grassland
    '000000',  // [13] --
    'ffefc3',  // [14] Agricultural and Livestock Area
    'fbf0ab',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    '000000',  // [18] --
    'c27ba0',  // [19] Agriculture
    '000000',  // [20] --
    '000000',  // [21] --
    'd4271e',  // [22] Non-vegetated Area
    '000000',  // [23] --
    '000000',  // [24] --
    '000000',  // [25] --
    '2532e4',  // [26] Water Body
    'ffffff',  // [27] Not Observed
    '000000',  // [28] --
    '000000',  // [29] --
    '000000',  // [30] --
    '000000',  // [31] --
    '000000',  // [32] --
    '2532e4',  // [33] River, Lake or Ocean
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
    '000000',  // [76] --
    '000000',  // [77] --
    '000000',  // [78] --
    '67671c',  // [79] Pinus Plantation
    '886827',  // [80] Eucalyptus Plantation
    '000000',  // [81] --
    '000000',  // [82] --
    'ab8231',  // [83] Other Types of Forest Plantation
  ],
};

// Tacuarembo department - representative forest plantation area in Uruguay
var region = ee.Geometry.Point([-55.8, -32.0]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Uruguay LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
