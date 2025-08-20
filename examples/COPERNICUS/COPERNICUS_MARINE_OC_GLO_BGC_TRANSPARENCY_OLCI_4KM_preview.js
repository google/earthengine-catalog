var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/TRANSPARENCY_OLCI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));

var KD490 = dataset.select('KD490').mean();
var vis = {
  min: 0.021,
  max: 0.212,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};

var image = KD490.visualize(vis);

var lon = -77.1056;
var lat = 38.8904;

var geometry = ee.Geometry.Polygon(
    [[
      [-178.29486965477756, 75.25000324561191],
      [-178.29486965477756, -3.086671633971673],
      [-22.904244654777564, -3.086671633971673],
      [-22.904244654777564, 75.25000324561191]
    ]],
    null, false);
var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));