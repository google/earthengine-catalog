var dataset = ee.FeatureCollection('TIGER/2010/Blocks');
var visParams = {
  min: 0.0,
  max: 700.0,
  palette: ['black', 'brown', 'yellow', 'orange', 'red']
};

// Turn the strings into numbers
dataset = dataset.map(function (f) {
  return f.set('pop10', ee.Number.parse(f.get('pop10')));
});

var image = ee.Image().float().paint(dataset, 'pop10');

Map.setCenter(-73.99172, 40.74101, 13);
Map.addLayer(image, visParams, 'TIGER/2010/Blocks');
Map.addLayer(dataset, null, 'for Inspector', false);
