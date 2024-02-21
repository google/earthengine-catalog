var dataset = ee.FeatureCollection('GLIMS/current');

var visParams = {
  palette: ['black', 'lightgray', 'cyan', 'blue'],
  min: 0.0,
  max: 10.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint({featureCollection: dataset, color: 'area'});
var outlinedImage = image.paint({featureCollection: dataset, color: 0, width: 1});

Map.setCenter(-35.618, 66.743, 8);
Map.addLayer(outlinedImage, visParams, 'GLIMS/current');


var lon = -35.618;
var lat = 66.465;

var deltaLon = .5;
var deltaLat = .2;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - deltaLon, lat - deltaLat, lon + deltaLon, lat + deltaLat], null, false);

var imageParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:4326',
    format: 'png',
};
print(ui.Thumbnail({image: outlinedImage.visualize(visParams), params: imageParams}));