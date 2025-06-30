/**
  MapBiomas Collection 9 - LULC Preview Thumbnail for 2023
*/

// Asset path for MapBiomas Collection 9
var assetPath = 'projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_integration_v1';

// Load the official palette
var palette = require('users/mapbiomas/modules:Palettes.js').get('classification9');

// Select the 2023 classification band
var image = ee.Image(assetPath).select('classification_2023');

// Define a representative region of interest (e.g., Xingu/MT)
var region = ee.Geometry.Point([-55.7101, -11.6686]).buffer(20000).bounds();

// Visualization parameters
var visParams = {
  min: 0,
  max: 69,
  palette: palette
};

// Optional: Preview in the map interface
Map.centerObject(region, 9);
Map.addLayer(image, visParams, 'MapBiomas LULC 2023');
Map.addLayer(region, { color: 'red' }, 'Region of Interest');

// Parameters for thumbnail preview
var imageParams = {
  region: region,
  dimensions: 256,
  format: 'png'
};

// Print thumbnail (used in the Earth Engine catalog page)
print(ui.Thumbnail({
  image: image.visualize(visParams),
  params: imageParams,
  style: {
    height: '256px',
    width: '256px'
  }
}));
