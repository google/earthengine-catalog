var dataset = ee.ImageCollection('MODIS/061/MYD13A3')
                  .filter(ee.Filter.date('2020-01-01', '2023-05-01'));
var NDVI = dataset.select('NDVI').mean();
var NDVIVis = {
  min: 0,
  max: 9000,
  palette: ['ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
  '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
  '012e01', '011d01', '011301'],
};

var lon = 19.95;
var lat = 2.38;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(NDVI, NDVIVis, 'NDVI');

// Degrees in EPSG:3857.
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var image = NDVI.visualize(NDVIVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
