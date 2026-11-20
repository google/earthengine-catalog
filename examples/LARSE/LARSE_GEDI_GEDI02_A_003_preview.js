var dataset = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_A_003/' +
    'GEDI02_A_2021244154857_O15413_04_T05622_02_004_02_V003');
var styled = dataset.style({color: '004d00', pointSize: 1});

var lon = -64.88;
var lat = -31.77;
var delta = 0.01;
var lonDelta = delta / Math.cos(lat * (Math.PI / 180));

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - delta, lon + lonDelta, lat + delta], null, false);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
var imageWithBackground = waterLandBackground.blend(styled);

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(lon, lat, 15);
Map.addLayer(imageWithBackground, {}, 'Preview');
