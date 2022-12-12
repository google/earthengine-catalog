var dataset = ee.FeatureCollection('TIGER/2010/Tracts_DP1');
var visParams = {
  min: 0,
  max: 4000,
  opacity: 0.8,
};

// Turn the strings into numbers
dataset = dataset.map(function (f) {
  return f.set('shape_area', ee.Number.parse(f.get('dp0010001')));
});

Map.setCenter(-103.882, 43.036, 8);
var image = ee.Image().float().paint(dataset, 'dp0010001');

Map.addLayer(image, visParams, 'TIGER/2010/Tracts_DP1');
Map.addLayer(dataset, null, 'for Inspector', false);
