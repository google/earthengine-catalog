var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP15A2H')
                  .filter(ee.Filter.date('2022-11-01', '2022-12-01'));

var visualization = {
  bands: ['Lai'],
  min: [0],
  max: [3],
  palette: [
    'a50026',
    'd73027',
    'f46d43',
    'fdae61',
    'fee08b',
    'ffffbf',
    'd9ef8b',
    'a6d96a',
    '66bd63',
    '1a9850',
    '006837',
  ]
};

var lon = 7.347;
var lat = 59.085;
var pixels = 64;
Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 12.5;

Map.addLayer(dataset, visualization, 'Leaf Area Index (LAI)');

var rgb = dataset.select(['Lai']).mosaic().visualize(visualization);

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a background image
var backgroundImage = ee.Image.constant(1).visualize({palette: ['#808080']});

// Combine images
var combinedImage = backgroundImage.blend(rgb);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'SR-ORG:6974',
  format: 'png',
};

print(ui.Thumbnail({image: combinedImage, params: visParams}));

