var image = ee.Image('IMD/RAINFALL/20240715');

var visualization = {
  bands: ['rainfall'],
  min: 0.0,
  max: 50.0,
  palette: ['ffffcc', 'a1dab4', '41b6c4', '2c7fb8', '253494'],
};

var lon = 82.5;
var lat = 22.5;
var delta = 17.5;

var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visualizedImage = image.visualize(visualization);

// Overlay on top of ETOPO1 bedrock background.
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
Map.addLayer(imageWithBackground, {}, 'Daily Rainfall Preview');
