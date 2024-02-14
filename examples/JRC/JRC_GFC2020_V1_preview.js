var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var dataVisualization = {
  bands: ['Map'],
  palette: ['4D9221']};

var dataset =
    ee.ImageCollection('JRC/GFC2020/V1').mosaic().visualize(dataVisualization);

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, dataset]).mosaic();

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(dataset, {}, 'EC JRC Global forest cover 2020 – V1');

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
