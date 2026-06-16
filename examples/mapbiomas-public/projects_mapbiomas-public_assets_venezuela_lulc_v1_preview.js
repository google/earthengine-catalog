/**
  MapBiomas Venezuela - Land Use and Land Cover V1 - Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/venezuela/lulc/v1';

var year = 2024;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 82,
  palette: [
    '000000',  // [0] --
    '1f8d49',  // [1] Forest Formations
    '000000',  // [2] --
    '1f8d49',  // [3] Forest
    '7dc975',  // [4] Wooded Savanna
    '04381d',  // [5] Mangrove
    '026975',  // [6] Flooded Forest
    '000000',  // [7] --
    '000000',  // [8] --
    '7a6c00',  // [9] Forest Plantation
    'd6bc74',  // [10] Grasslands and Shrublands
    '519799',  // [11] Flooded Grassland/Shrubland
    'd6bc74',  // [12] Grassland
    'd89f5c',  // [13] Other Non-forest Natural Formations
    'ffefc3',  // [14] Agricultural Areas
    'edde8e',  // [15] Pasture/Fallow Lands
    '000000',  // [16] --
    '000000',  // [17] --
    'e974ed',  // [18] Agriculture/Fallow Lands
    '000000',  // [19] --
    '000000',  // [20] --
    'ffefc3',  // [21] Cropland/Pasture/Fallow Lands
    'd4271e',  // [22] Non-vegetated Areas
    'ffa07a',  // [23] Beach or Dune
    'd4271e',  // [24] Urban
    'db4d4f',  // [25] Other Non-vegetated Anthropic Areas
    '2532e4',  // [26] Water Bodies
    'ffffff',  // [27] Not Observed
    '000000',  // [28] --
    'ffaa5f',  // [29] Rocky Outcrop
    '9c0027',  // [30] Mining
    '000000',  // [31] --
    'fc8114',  // [32] Hypersaline Tidal Flat
    '000000',  // [33] --
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
    'ad5100',  // [50] Xerophytic Grassland/Shrubland
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
    '000000',  // [67] --
    'e97a7a',  // [68] Other Non-vegetated Natural Areas
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
    '000000',  // [79] --
    '000000',  // [80] --
    'dfeb62',  // [81] Andean Herbaceous/Shrubby Vegetation
    '6fc179',  // [82] Flooded Andean Herbaceous/Shrubby Vegetation
  ],
};

// Los Llanos region - representative savanna area in Venezuela
var region = ee.Geometry.Point([-67.5, 8.0]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Venezuela LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
