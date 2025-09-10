/**
  MapBiomas Collection 10 - LULC Preview Thumbnail for 2024
*/

// Define the asset path for MapBiomas land use/land cover (LULC) data
var assetPath = 'projects/mapbiomas-public/assets/brazil/lulc/v1';

// Import the official MapBiomas palette for Brazil
var palette = require('users/mapbiomas/modules:Palettes.js').get('brazil');

var year = 2024;

// Load the classified image for the year 2024 from Collection 10
var collection = ee.ImageCollection(assetPath)
	.filter(ee.Filter.eq('collection_id', 10.0))
	.filter(ee.Filter.eq('version', 'v2'))
	.filter(ee.Filter.eq('year', year));

// Define visualization parameters
var visParams = {
	min: 0,
	max: 75,  // Maximum class value in Collection 10
	palette: palette
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
