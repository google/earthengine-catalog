var dataset = ee.ImageCollection('NASA/ORNL/global_forest_classification_2020/V1');
var visualization = {
  bands: ['classification'],
  min: 1.0,
  max: 3.0,
  palette: ['00ff00', 'ff0000', '6666ff'],
};
Map.setCenter(-31, -4, 8);
Map.addLayer(dataset, visualization, 'Forest Type');
var lon = 31;
var lat = -4;
var pixels = 256;
Map.setCenter(lon, lat, 8);
Map.setOptions('SATELLITE');
// Degrees in SR-ORG:6974
var delta = 1;
var rgb = dataset.select(['classification']).mosaic().visualize(visualization);
var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
// Create a background image
var backgroundImage = ee.Image.constant(1).visualize({palette: ['#808080']});
// Combine images
var combinedImage = backgroundImage.blend(rgb);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'SR-ORG:6974',
  format: 'png',
};
print(ui.Thumbnail({image: combinedImage, params: visParams}));
