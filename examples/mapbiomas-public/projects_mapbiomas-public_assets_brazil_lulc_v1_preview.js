/**
  MapBiomas Brazil - LULC Preview Thumbnail
*/

var assetPath = 'projects/mapbiomas-public/assets/brazil/lulc/v1';

var year = 2025;

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

// Define visualization parameters
var visParams = {
	min: 0,
	max: 91,  // Maximum class value in the legend
	palette: [
	'000000',  // [0] --
	'1f8d49',  // [1] Forest
	'000000',  // [2] --
	'1f8d49',  // [3] Forest Formation
	'7dc975',  // [4] Savanna Formation
	'04381d',  // [5] Mangrove
	'007785',  // [6] Flooded Forest
	'228c70',  // [7] Flooded Savanna (beta)
	'000000',  // [8] --
	'7a5900',  // [9] Silviculture
	'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
	'519799',  // [11] Flooded Grassland and Wetland
	'd6bc74',  // [12] Grassland Formation
	'000000',  // [13] --
	'ffefc3',  // [14] Agriculture and Livestock
	'edde8e',  // [15] Pasture
	'000000',  // [16] --
	'000000',  // [17] --
	'e974ed',  // [18] Agriculture
	'c27ba0',  // [19] Temporary Crop
	'db7093',  // [20] Sugarcane
	'ffefc3',  // [21] Mosaic of Uses
	'd4271e',  // [22] Non-vegetated Area
	'ffa07a',  // [23] Beach, Dune, and Sandbank
	'd4271e',  // [24] Urban Area
	'db4d4f',  // [25] Other Non-Vegetated Areas
	'2532e4',  // [26] Water Body
	'000000',  // [27] --
	'000000',  // [28] --
	'ad5100',  // [29] Rocky Outcrop
	'9c0027',  // [30] Mining
	'091077',  // [31] Aquaculture
	'fc8114',  // [32] Hypersaline Flat
	'2532e4',  // [33] River, Lake, and Ocean
	'000000',  // [34] --
	'9065d0',  // [35] Oil Palm
	'd082de',  // [36] Perennial Crop
	'000000',  // [37] --
	'000000',  // [38] --
	'f5b3c8',  // [39] Soybean
	'c71585',  // [40] Rice
	'f54ca9',  // [41] Other Temporary Crops
	'000000',  // [42] --
	'000000',  // [43] --
	'000000',  // [44] --
	'000000',  // [45] --
	'd68fe2',  // [46] Coffee
	'9932cc',  // [47] Citrus
	'e6ccff',  // [48] Other Perennial Crops
	'02d659',  // [49] Arboreal Restinga
	'ffaa5f',  // [50] Herbaceous or Shrubby Restinga
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
	'ff69b4',  // [62] Cotton (beta)
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
	'757272',  // [75] Photovoltaic Plant
	'000000',  // [76] --
	'86b074',  // [77] Herbaceous-Shrub Formation
	'000000',  // [78] --
	'000000',  // [79] --
	'000000',  // [80] --
	'000000',  // [81] --
	'000000',  // [82] --
	'000000',  // [83] --
	'81dbbf',  // [84] Salt Marsh (beta)
	'000000',  // [85] --
	'000000',  // [86] --
	'000000',  // [87] --
	'000000',  // [88] --
	'000000',  // [89] --
	'000000',  // [90] --
	'403d3e',  // [91] Wind farm (beta)
	]
};

// Define a representative region of interest (e.g., Sinop/MT)
var region = ee.Geometry.Point([-55.7101, -11.6686]).buffer(20000).bounds();

// Optional: Preview in the map interface
Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas LULC 2024');
Map.addLayer(region, { color: 'red' }, 'Region of Interest');

// Parameters for thumbnail preview
var imageParams = {
	region: region,
	dimensions: 256,
	format: 'png'
};

// Print thumbnail (used in the Earth Engine catalog page)
print(ui.Thumbnail({
	image: collection.mosaic().visualize(visParams),
	params: imageParams,
	style: {
		height: '256px',
		width: '256px'
	}
}));
