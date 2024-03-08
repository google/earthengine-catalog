var dataset = ee.ImageCollection('NASA/EMIT/L2B/CH4ENH');
var emitEnhancement = dataset.select('vertical_column_enhancement').mean();
var emitEnhancementVis = {
  min: 0,
  max: 100.0,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};


var lon = -100.24;
var lat = 32.04;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 5);

// Degrees in EPSG:3857.
var delta = 20;
// Width and height of the thumbnail image.
var pixels = 256;

var image = emitEnhancement.visualize(emitEnhancementVis);
var imageWithBackground = ee.ImageCollection([waterLandBackground, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, null, 'Emit Enhancement');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
