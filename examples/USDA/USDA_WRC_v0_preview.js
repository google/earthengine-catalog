var wrc = ee.ImageCollection('USDA/WRC/v0').mosaic();

// Add background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var vis = {min: 0, max: 30, palette: ['white', 'red']}
var cfl = wrc.select('CFL').visualize(vis);

var lon = -95;
var lat = 39;

// Degrees in EPSG:4326.
var lat_delta = 25;
var lon_delta = 35;

// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var imageWithBackground = ee.ImageCollection([waterLandBackground, cfl]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.addLayer(cfl, {}, 'Conditional Flame Length');
Map.setCenter(-101, 39, 4)