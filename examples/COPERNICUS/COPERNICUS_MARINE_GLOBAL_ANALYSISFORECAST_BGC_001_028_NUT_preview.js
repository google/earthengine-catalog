var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/NUT")
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));
var no3 = dataset.select('no3_depth1').mean();
var no3Vis = {
  min: 1,
  max: 10,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};

var image = no3.visualize(no3Vis);

var lon = -107.22;
var lat = 32.92;

var geometry = ee.Geometry.Polygon(
    [[[-130, 40],
      [-130, -20],
      [-55, -10],
      [-55, 55]]],
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
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
