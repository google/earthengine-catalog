var image = ee.ImageCollection('COPERNICUS/MARINE/WAV/ANFC_0_083DEG_STATIC').first();
print(image)
var seaFloorDepth = image.select('deptho');
var seaFloorDepthVis = {
  min: 0,
  max: 300,
  palette: ['ccccff', '0000ff'],
};

var image = seaFloorDepth.visualize(seaFloorDepthVis);

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
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(lon, lat, 2);
Map.addLayer(imageWithBackground);

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));