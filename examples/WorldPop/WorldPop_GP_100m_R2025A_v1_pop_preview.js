var image = ee.ImageCollection('WorldPop/GP/100m/R2025A/v1/pop')
    .filter(ee.Filter.eq('year', 2025))
    .select('population')
    .mosaic();

var visualization = {
  bands: ['population'],
  min: 0.0,
  max: 50.0,
  palette: ['24126c', '1fff4f', 'd4ff50']
};

var lon = 113.643;
var lat = 34.769;
var delta = 3.5;

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
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(lon, lat, 7);
Map.addLayer(imageWithBackground, {}, 'Preview');
