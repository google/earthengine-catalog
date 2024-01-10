var dataset = ee.Image('UMT/Climate/IrrMapper_RF/v1_2/ID_2021');

var lon = -112.381;
var lat = 44.0;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:4326
var delta = 0.3;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
Map.addLayer(background);

var image = dataset.visualize({palette:['blue'], min: 0, max: 1});
Map.addLayer(dataset, {palette:['blue'], opacity: 1.0}, 'IrrMapper Vers 1.2', true);

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));