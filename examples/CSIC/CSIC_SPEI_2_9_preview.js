// Retrieve the last date from the SPEI dataset.
var dataset = ee.ImageCollection('CSIC/SPEI/2_9').
  filterDate('2022-12-01', '2023-01-01');

// Select the 24-month analysis.
var et = dataset.select('SPEI_24_month').first();

var visParams = {
  min: -2.33,
  max:  2.33,
  palette: [
    '8b1a1a', 'de2929', 'f3641d',
    'fdc404', '9afa94', '03f2fd',
    '12adf3', '1771de', '00008b',
  ],
};

// cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});
Map.addLayer(background, {}, 'background', false, 0.7);

var image = et.visualize(visParams);
Map.addLayer(image, {}, 'SPEI 24 month', true, 0.3);

var lon = 20;
var lat = 4;
Map.setCenter(lon, lat, 3);

// Degrees in EPSG:3857.
var lonDelta = 40;
var latDelta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
  null, false);

Map.addLayer(areaOfInterest, {}, 'Area of Interest', true, 0.3);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
