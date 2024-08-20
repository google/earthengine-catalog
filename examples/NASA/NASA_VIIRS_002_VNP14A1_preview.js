var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP14A1')
                  .filter(ee.Filter.date('2017-05-01', '2017-12-30'));
var visualization = {
  bands:['MaxFRP'],
  min: 0.0,
  max: 1.0,
  palette: ['#00FF00', '#00FFFF', '#90EE90', '#ADFF2F', '#7CFC00', '#FFFFE0', '#FFFFA0', '#FFFF00'],
};
Map.addLayer(dataset, visualization, 'MaxFRP');

var lon = 38.06;
var lat = -14.22;
var pixels = 256;
Map.setCenter(lon, lat, 5);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 12.5;

Map.addLayer(dataset, visualization, 'MaxFRP');

var rgb = dataset.select(['MaxFRP']).mosaic().visualize(visualization);

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a background image
var backgroundImage = ee.Image.constant(1).visualize({palette: ['#000000']});

// Combine images
var combinedImage = backgroundImage.blend(rgb);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'SR-ORG:6974',
  format: 'png',
};

print(ui.Thumbnail({image: combinedImage, params: visParams}));