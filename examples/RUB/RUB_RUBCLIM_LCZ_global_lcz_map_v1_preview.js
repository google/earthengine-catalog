var dataset = ee.ImageCollection('RUB/RUBCLIM/LCZ/global_lcz_map/v1').mosaic();

var visualization = {
  bands: ['LCZ_Filter'],
  min: 1,
  max: 17,
  palette: [
    '8c0000','d10000','ff0000','bf4d00','ff6600',
    'ff9955','faee05','bcbcbc','ffccaa','555555',
    '006a00','00aa00','648525','b9db79','000000',
    'fbf7ae','6a6aff'
    ]
};
var image = dataset.visualize(visualization);

var lon = -73.951;
var lat = 40.8163;

Map.setCenter(lon, lat, 10);

// For background, use a product with ~ same resolution
var cgls = ee.Image('COPERNICUS/Landcover/100m/Proba-V-C3/Global/2019')
.select('discrete_classification').eq(80);
var backgroundPalette = ['#6a6aff'];
var waterLandBackground = cgls.visualize({palette: backgroundPalette});

// Degrees in EPSG:3857
var lonDelta = 0.5;
var latDelta = 0.5;

// Width and height of the thumbnail image.
var pixels = 256;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
    null,
    false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, null, 'LCZ filter with background');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
