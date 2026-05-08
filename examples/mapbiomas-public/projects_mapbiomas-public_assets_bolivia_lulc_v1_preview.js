/**
  MapBiomas Bolivia - Land Use and Land Cover V1 - Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/bolivia/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 82,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest Formation
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '7dc975',  // [4] Open Forest
    '000000',  // [5] --
    '026975',  // [6] Flooded Forest
    '000000',  // [7] --
    '000000',  // [8] --
    '000000',  // [9] --
    'd6bc74',  // [10] Grassland and shrubland
    '519799',  // [11] Flooded grassland/shrubland
    'd6bc74',  // [12] Grassland/shrubland
    'd89f5c',  // [13] Other non-forest natural formation
    'ffefc3',  // [14] Farming
    'edde8e',  // [15] Pasture
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of Uses
    'd4271e',  // [22] Non-vegetated area
    'ffa07a',  // [23] Beach, dune and sandbank
    'd4271e',  // [24] Urban Infrastructure
    'db4d4f',  // [25] Other non-vegetated anthropic area
    '2532e4',  // [26] Water
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky outcrop
    '9c0027',  // [30] Mining
    '091077',  // [31] Aquaculture
    '000000',  // [32] --
    '2532e4',  // [33] River and lake
    '93dfe6',  // [34] Glacier
    '000000',  // [35] --
    '000000',  // [36] --
    '000000',  // [37] --
    '000000',  // [38] --
    'f5b3c8',  // [39] Soybean
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
    'f5d5d5',  // [61] Salt flat
    '000000',  // [62] --
    '000000',  // [63] --
    '000000',  // [64] --
    '000000',  // [65] --
    'a89358',  // [66] Scrubland
    '000000',  // [67] --
    'e97a7a',  // [68] Other non-vegetated natural area
    '000000',  // [69] --
    '000000',  // [70] --
    '000000',  // [71] --
    'c1799c',  // [72] Other crops
    '000000',  // [73] --
    '000000',  // [74] --
    '000000',  // [75] --
    '000000',  // [76] --
    '000000',  // [77] --
    '000000',  // [78] --
    '000000',  // [79] --
    '000000',  // [80] --
    'c8c099',  // [81] Andean grassland and shrubland
    '66b2a3',  // [82] Flooded Andean grassland and shrubland
  ],
};

// Santa Cruz department - representative area with mixed land use in Bolivia
var region = ee.Geometry.Point([-60.5, -17.8]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Bolivia LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
