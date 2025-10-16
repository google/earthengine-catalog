var image2 = ee.ImageCollection('COPERNICUS/MARINE/WAV/ANFC_0_083DEG_PT3H').filter(ee.Filter.date('2025-04-1', '2025-04-30'));
var significantWaveHeight = image2.select('VHM0').mean();
var significantWaveHeightVis = {
  min: 0,
  max: 10,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};

var image = significantWaveHeight.visualize(significantWaveHeightVis);

var lon = -107.22;
var lat = 32.92;

var geometry = ee.Geometry.BBox(126, -47, 176, -7);
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
Map.addLayer(imageWithBackground);

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));