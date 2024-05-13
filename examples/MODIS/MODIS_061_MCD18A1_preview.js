var dataset = ee.ImageCollection('MODIS/061/MCD18A1')
                  .filter(ee.Filter.date('2000-01-01', '2001-01-01'));
var gmt_1200_dsr = dataset.select('GMT_1200_DSR').mean();
var gmt_1200_dsrVis = {
  min: 0,
  max: 350,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};

var lon = 72;
var lat = 23;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(gmt_1200_dsr, gmt_1200_dsrVis, 'GMT_1200_DSR');

// Degrees in EPSG:3857.
var delta = 20;
// Width and height of the thumbnail image.
var pixels = 256;

var image = gmt_1200_dsr.visualize(gmt_1200_dsrVis);
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
