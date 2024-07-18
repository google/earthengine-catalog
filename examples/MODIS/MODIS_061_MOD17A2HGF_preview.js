/**
 * @fileoverview Description of this file.
 */

var dataset = ee.ImageCollection('MODIS/061/MOD17A2HGF')
                  .filter(ee.Filter.date('2021-01-01', '2021-05-01'));
var gpp = dataset.select('Gpp').mean();
var gppVis = {
  min: 0,
  max: 600,
  palette: ['bbe029', '0a9501', '074b03'],
};

var lon = 6.746;
var lat = 46.529;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 2);
Map.addLayer(gpp, gppVis, 'GPP');

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = gpp.visualize(gppVis);
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
