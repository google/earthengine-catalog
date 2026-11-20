var dataset = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_B_003/' +
    'GEDI02_B_2021043114136_O12295_03_T07619_02_004_01_V003');
var styled = dataset.style({color: '004d00', pointSize: 1});

var lon = 12.60033;
var lat = 51.01051;
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
