var dataset = ee.ImageCollection('NOAA/CDR/VIIRS/NDVI/V1')
                  .filter(ee.Filter.date('2018-02-01', '2018-03-01'));
var ndvi = dataset.select('NDVI').first();
var ndviVis = {
  min: -1000.0,
  max: 5000.0,
  palette: [
    'ffffff', 'ce7e45', 'fcd163', 'c6ca02', '22cc04', '99b718', '207401',
    '012e01'
  ],
};

var lon = 7.71;
var lat = 17.93;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(ndvi, ndviVis, 'NDVI');

// Degrees in EPSG:3857.
var delta = 25;
// Width and height of the thumbnail image.
var pixels = 256;

var image = ndvi.visualize(ndviVis);
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
