/**
  MapBiomas Atlantic Forest - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/atlantic_forest/lulc/v1';

var year = 2023;
var version = 'v1';
var collectionId = 4;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 65,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest
    '000000',  // [2] --
    '1f8d49',  // [3] Forest Formation
    '7dc975',  // [4] Savanna Formation
    '04381d',  // [5] Mangrove
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Forest Plantation
    'd6bc74',  // [10] Non Forest Natural Formation
    '519799',  // [11] Flooded grasslands
    'd6bc74',  // [12] Grassland
    'd89f5c',  // [13] Other non Forest Formations
    'ffefc3',  // [14] Farming
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    'c27ba0',  // [19] Annual Crops
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of Uses
    'd4271e',  // [22] Non vegetated area
    '000000',  // [23] --
    '000000',  // [24] --
    '000000',  // [25] --
    '2532e4',  // [26] Water
    'ffffff',  // [27] Not Observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky Outcrop
    '000000',  // [30] --
    '091077',  // [31] Aquaculture
    'fc8114',  // [32] Hypersaline Tidal Flat
    '2532e4',  // [33] River, Lake and Ocean
    '000000',  // [34] --
    '000000',  // [35] --
    'd082de',  // [36] Perennial Crop
    '000000',  // [37] --
    '000000',  // [38] --
    '000000',  // [39] --
    '000000',  // [40] --
    '000000',  // [41] --
    '000000',  // [42] --
    '000000',  // [43] --
    '000000',  // [44] --
    '000000',  // [45] --
    'd68fe2',  // [46] Coffee
    '000000',  // [47] --
    'e6ccff',  // [48] Other Perennial Crops
    '02d659',  // [49] Wooded Sandbank Vegetation
    'ad5100',  // [50] Herbaceous Sandbank Vegetation
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
    'b9158a',  // [65] Tea
  ],
};

// southern Minas Gerais - coffee, pasture and forest remnants
var region = ee.Geometry.Point([-46.5, -21.5]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Atlantic Forest LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
