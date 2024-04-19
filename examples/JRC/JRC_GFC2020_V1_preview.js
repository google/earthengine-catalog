var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var dataVisualization = {
  bands: ['Map'],
  palette: ['4D9221']};

var image2020 =
    ee.ImageCollection('JRC/GFC2020/V1').filterDate(
      '2020-12-31').first().visualize(dataVisualization);

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image2020]).mosaic();

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(image2020, {}, 'EC JRC Global forest cover 2020 – V1');

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
