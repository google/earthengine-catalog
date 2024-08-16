var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP13A1')
                  .filter(ee.Filter.date('2017-05-01', '2017-06-30'));

var visualization = {
  bands: ['EVI'],
  min: 0.0,
  max: 1.0,
  palette: ['000000', '004400', '008800', '00bb00', '00ff00'],
};
// Map.setCenter(17.93, 7.71, 6);
Map.addLayer(dataset, visualization, 'RGB');

var lon = 7.347;
var lat = 59.085;
var pixels = 256;
Map.setCenter(lon, lat, 5);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 12.5;

Map.addLayer(dataset, visualization, 'EVI');

var rgb = dataset.select(['EVI']).mosaic().visualize(visualization);

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
