var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/NRT_DAILY')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));

var DOS = dataset.select('dos').mean();
var vis = {
  min: 1020.41,
  max: 1027.596,
  palette:
      ["040613","121328","3F59A5","3E80C0","3EADCB","8CCBD6","EAFDFD"],
};

var image = DOS.visualize(vis);

var lon = -77.1056;
var lat = 38.8904;

var geometry = ee.Geometry.Polygon(
    [[
      [-130, 55],
      [-130, -10],
      [-55, -10],
      [-55, 55],
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
var backgroundPalette = ['cadetblue', 'beige'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));