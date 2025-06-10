var dataset = ee.ImageCollection('UCSB/CHC/CMIP6/v1')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var chrips = dataset.select('CHIRPS').mosaic();
var chripsVis = {
  min: 0,
  max: 100.0,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};

var lon = 93.17;
var lat = 10.14;


var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 4);

// Degrees in EPSG:3857.
var delta = 30;
// Width and height of the thumbnail image.
var pixels = 256;

var image = chrips.visualize(chripsVis);
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, null, 'CHC CMIP6');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));