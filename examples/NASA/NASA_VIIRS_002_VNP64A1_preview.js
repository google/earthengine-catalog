// Define the specific image asset.
var image = ee.Image('NASA/VIIRS/002/VNP64A1/2025_12_01');

// Define visualization parameters for the 'Last_Day' band.
var visualization = {
  bands: ['Last_Day'],
  min: 250.0,
  max: 320.0,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
};

// 2. Define center and vertical span
var lon = -98;    // Center of interest (Longitude)
var lat = 38;     // Center of interest (Latitude)
var delta = 35;   // The vertical (Latitude) half-span


var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visualizedImage = image.visualize(visualization);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, visualizedImage]).mosaic();

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(-119.13, 38.32, 3);
Map.addLayer(imageWithBackground, {}, 'Last day Preview');
