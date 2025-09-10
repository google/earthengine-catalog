/**
  MapBiomas Collection 10 - LULC Visualization for 2024
*/

// Define the asset path for MapBiomas Collection 9
var assetPath = 'projects/mapbiomas-public/assets/brazil/lulc/v1';

// Import the official MapBiomas palette for Collection 9
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
	palette: palette,
	format: 'png'
};

// Add the layer to the map
Map.addLayer(collection, visParams, 'MapBiomas LULC 2024');

// Center the map on the image with a zoom level of 5 (covers Brazil)
Map.centerObject(collection, 5);
