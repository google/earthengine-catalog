var dataset = ee.FeatureCollection('TIGER/2020/ZCTA5');

var lon = -99.844;
var lat = 37.649;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var background = waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var image = ee.Image().float().paint(dataset, 'ALAND20');

var visParams = {
  palette: ['purple', 'blue', 'green', 'yellow', 'orange', 'red'],
  min: 500000,
  max: 500000000,
};

var visualized = image.visualize(visParams);
var imageWithBackground = background.blend(visualized);

var pixels = 256;
var lat_delta = 5;
var lon_delta = 5;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
