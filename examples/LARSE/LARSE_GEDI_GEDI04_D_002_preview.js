var dataset = ee.ImageCollection('LARSE/GEDI/GEDI04_D_002');
var image = dataset.mosaic();

var visualization = {
  bands: ['agbd'],
  min: 1.0,
  max: 60.0,
  palette: [
    'darkred',
    'red',
    'orange',
    'green',
    'darkgreen'
  ]
};

var lon = -60.0;
var lat = -5.0;
var delta = 30; // vertical span

var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visualizedImage = image.visualize(visualization);

// Overlay on top of ETOPO1 bedrock background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground = waterLandBackground.blend(visualizedImage);

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(lon, lat, 4);
Map.addLayer(imageWithBackground, {}, 'Preview');
