var dataset = ee.FeatureCollection('HU_BERLIN/EPFD/V2/polygons');


var empty_image = ee.Image().byte();

// Paint all the polygon edges with the same number and width, display.
var forest = empty_image.paint({
  featureCollection: dataset,
  color: 1,
  width: 1
});


var forest_vis = {
  palette: ['000000'],
};

var lon = 39.64;
var lat = 61.11;

Map.setCenter(lon, lat, 4);
Map.addLayer(
  forest,
  forest_vis,
  'European Primary Forest Polygons');

// Degrees in EPSG:4326.
var lat_delta = 10;
var lon_delta = 15;
// Width and height of the thumbnail image.
var pixels = 256;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var image = forest.visualize(forest_vis);
var imageWithBackground = ee.ImageCollection([waterLandBackground, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
