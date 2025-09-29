var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/REP_DAILY')
        .filter(ee.Filter.date('2023-12-16', '2023-12-17'));

var SOS = dataset.select('sos').mean();
var vis = {
  min: 27.869,
  max: 36.981,
  palette:
      ["040613","121328","3F59A5","3E80C0","3EADCB","8CCBD6","EAFDFD"],
};

var image = SOS.visualize(vis);

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