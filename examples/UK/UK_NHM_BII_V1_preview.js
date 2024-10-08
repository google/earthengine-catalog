var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var colorPalette = [
  '#001a00', // Very Dark Green (Almost Black)
  '#002600', // Dark Green (Almost Black)
  '#003300', // Very Dark Green
  '#004d00', // Dark Green
  '#006400', // Dark Green
  '#008000', // Medium Green
  '#00a86b', // Green
  '#00c896', // Green
  '#00e8c1', // Light Green
  '#90EE90', // Very Light Green
  '#F0FFF0' // Almost White Green
];

var dataVisualization = {
  bands: ['b1'],
  palette: colorPalette };

var image =
    ee.Image('UK/NHM/BII/V1/2005').visualize(dataVisualization);

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(image, {}, 'BII');

var lon = -70;
var lat = -10;

// Degrees in EPSG:3857.
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
