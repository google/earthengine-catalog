var dataset = ee.Image('WRI/SBTN/naturalLands/v1/2020').select('natural');

var lon = -30;
var lat = 10;

Map.setCenter(lon, lat, 6);

// Degrees in EPSG:4326
var delta = 64;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var backGround = ee.Image(1).visualize({palette: ['lightgray']})
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0).clip(
  ee.Geometry.BBox(-180, -55, 180, 75));
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var imageWithBg = backGround.blend(waterLandBackground.blend(dataset.visualize({})));

print(ui.Thumbnail({image: imageWithBg, params: visParams}));

Map.addLayer(imageWithBg, {}, 'Natural Lands');
