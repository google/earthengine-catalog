var dataset = ee.FeatureCollection('TIGER/2016/Counties');
var visParams = {
  palette: ['purple', 'blue', 'green', 'yellow', 'orange', 'red'],
  min: 0,
  max: 50,
  opacity: 0.8,
};
var stateDataset = ee.FeatureCollection('TIGER/2016/States');

// Turn the strings into numbers
dataset = dataset.map(function (f) {
  return f.set('STATEFP', ee.Number.parse(f.get('STATEFP')));
});

var image = ee.Image().float().paint(dataset, 'STATEFP');
var countyOutlines = ee.Image().float().paint({
  featureCollection: dataset,
  color: 'black',
  width: 1
});
var stateOutlines = ee.Image().float().paint({
  featureCollection: stateDataset,
  color: 'black',
  width: 3
});

Map.setCenter(-99.844, 37.649, 5);
Map.addLayer(image, visParams, 'TIGER/2016/Counties');
Map.addLayer(stateOutlines, {}, 'state outlines');
Map.addLayer(countyOutlines, {}, 'county outlines');
Map.addLayer(dataset, null, 'for Inspector', false);
