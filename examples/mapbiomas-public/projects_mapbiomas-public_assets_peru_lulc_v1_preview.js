/**
  MapBiomas Peru - Land Use and Land Cover V1 - Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/peru/lulc/v1';

var year = 2025;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 92,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest formation
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '7dc975',  // [4] Dry forest
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a5900',  // [9] Planted forest
    'd6bc74',  // [10] Natural non-forest formation
    '519799',  // [11] Flooded herbaceous formation
    'd6bc74',  // [12] Herbaceous formation
    'd89f5c',  // [13] Shrub and other non-forest formations
    'ffefc3',  // [14] Agricultural area
    'edde8e',  // [15] Pasture (beta)
    '000000',  // [16] --
    '000000',  // [17] --
    '000000',  // [18] --
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Mosaic of agriculture and pasture
    'd4271e',  // [22] Non-vegetated area
    'ffa07a',  // [23] Beach
    'd4271e',  // [24] Urban infrastructure
    'db4d4f',  // [25] Other anthropogenic non-vegetated area
    '2532e4',  // [26] Water body
    'ffffff',  // [27] Not observed
    '000000',  // [28] --
    '000000',  // [29] --
    '9c0027',  // [30] Mining
    '091077',  // [31] Aquaculture
    '000000',  // [32] --
    '2532e4',  // [33] River, lake or ocean
    '93dfe6',  // [34] Glacier
    '9065d0',  // [35] Oil palm
    '000000',  // [36] --
    '000000',  // [37] --
    '000000',  // [38] --
    '000000',  // [39] --
    'c71585',  // [40] Rice (beta)
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
    '5faf92',  // [51] Lowland flooded grassland
    'f0b4a8',  // [52] Coastal salt flat
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
    'a89358',  // [66] Shrubland and other shrub vegetation
    '000000',  // [67] --
    'e97a7a',  // [68] Other natural non-vegetated area
    '000000',  // [69] --
    'be9e00',  // [70] Fog oasis (beta)
    '000000',  // [71] --
    '000000',  // [72] --
    '000000',  // [73] --
    '000000',  // [74] --
    '000000',  // [75] --
    '000000',  // [76] --
    '000000',  // [77] --
    '000000',  // [78] --
    '000000',  // [79] --
    '000000',  // [80] --
    '000000',  // [81] --
    '26abab',  // [82] High andean flooded grassland
    '000000',  // [83] --
    '000000',  // [84] --
    '000000',  // [85] --
    '000000',  // [86] --
    '000000',  // [87] --
    '000000',  // [88] --
    '000000',  // [89] --
    '000000',  // [90] --
    '000000',  // [91] --
    'd98a45',  // [92] Rocky surface
  ],
};

// Madre de Dios region - representative Amazon rainforest area in Peru
var region = ee.Geometry.Point([-70.5, -12.0]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Peru LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
