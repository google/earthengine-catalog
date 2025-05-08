/**
  MapBiomas Collection 9 - LULC Visualization for 2023
*/

// Define the asset path for MapBiomas Collection 9
var assetPath = 'projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_integration_v1';

// Import the official MapBiomas palette for Collection 9
var palette = require('users/mapbiomas/modules:Palettes.js').get('classification9');

// Load the classified image for the year 2023
var image = ee.Image(assetPath).select('classification_2023');

// Define visualization parameters
var visParams = {
    min: 0,
    max: 69,  // Maximum class value in Collection 9
    palette: palette,
    format: 'png'
};

// Add the layer to the map
Map.addLayer(image, visParams, 'MapBiomas LULC 2023');

// Center the map on the image with a zoom level of 5 (covers Brazil)
Map.centerObject(image, 5);
