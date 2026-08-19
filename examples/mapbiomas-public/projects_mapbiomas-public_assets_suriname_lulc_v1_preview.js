/**
  MapBiomas Suriname - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/suriname/lulc/v1';

var year = 2025;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 33,
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
    '000000',  // [9] --
    'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
    '519799',  // [11] Wetland
    'd6bc74',  // [12] Grassland
    '000000',  // [13] --
    'ffefc3',  // [14] Farming
    '000000',  // [15] --
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of Uses
    'd4271e',  // [22] Non vegetated Area
    '000000',  // [23] --
    'd4271e',  // [24] Urban Area
    'db4d4f',  // [25] Other non Vegetated Area
    '2532e4',  // [26] Water
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    '000000',  // [29] --
    '9c0027',  // [30] Mining
    '000000',  // [31] --
    '000000',  // [32] --
    '2532e4',  // [33] River, lake and Ocean
  ],
};

// coastal plain near Paramaribo - mangrove, farming and urban area
var region = ee.Geometry.Point([-55.2, 5.75]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Suriname LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
