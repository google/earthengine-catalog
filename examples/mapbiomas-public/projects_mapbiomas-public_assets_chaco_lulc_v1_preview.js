/**
  MapBiomas Chaco - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/chaco/lulc/v1';

var year = 2023;
var version = 'v2';
var collectionId = 5;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 61,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Natural wooded vegetation
    '000000',  // [2] --
    '1f8d49',  // [3] Closed woodland
    '7dc975',  // [4] Open woodland
    '000000',  // [5] --
    '026975',  // [6] Flooded woodland
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Forest plantation
    'd6bc74',  // [10] Natural non-wooded vegetation
    '519799',  // [11] Flooded Grassland
    'd6bc74',  // [12] Grassland
    '000000',  // [13] --
    'ffefc3',  // [14] Agricultural and livestock areas
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    'c27ba0',  // [19] Annual Crops
    '000000',  // [20] --
    '000000',  // [21] --
    'd4271e',  // [22] Non-vegetated area
    'ffa07a',  // [23] Beach, Dune and Sand Spot
    'd4271e',  // [24] Urban Area
    'db4d4f',  // [25] Other non Vegetated Areas
    '2532e4',  // [26] Water bodies
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    '000000',  // [29] --
    '000000',  // [30] --
    '000000',  // [31] --
    '000000',  // [32] --
    '000000',  // [33] --
    '000000',  // [34] --
    '000000',  // [35] --
    'd082de',  // [36] Shrub plantation
    '000000',  // [37] --
    '000000',  // [38] --
    '000000',  // [39] --
    '000000',  // [40] --
    '000000',  // [41] --
    'a5b35b',  // [42] Open Grassland
    'c2d26b',  // [43] Closed Grassland
    'cbe286',  // [44] Sparse Grassland
    '807a40',  // [45] Sparse woodland
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
    'f99fff',  // [57] Single crop
    'd84690',  // [58] Multiple crop
    '000000',  // [59] --
    '000000',  // [60] --
    'f5d5d5',  // [61] Salt Flat
  ],
};

// Paraguayan Chaco - deforestation frontier and pasture
var region = ee.Geometry.Point([-60.5, -23.5]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Chaco LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
