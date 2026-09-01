var image = ee.Image('CSIRO/BHI/v4/BILBI_P_BHIv4_2020');

var visualization = {
  bands: ['bhi'],
  min: 0.0,
  max: 1.0,
  palette: ['440154', '3b528b', '21918c', '5ec962', 'fde725']
};

var lon = 133.78;
var lat = -25.27;
var delta = 15.0;

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

Map.setCenter(lon, lat, 4);
Map.addLayer(imageWithBackground, {}, 'Preview');
