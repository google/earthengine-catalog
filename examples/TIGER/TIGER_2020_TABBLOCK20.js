var dataset = ee.FeatureCollection('TIGER/2020/TABBLOCK20');

var visParams = {
  min: 0.0,
  max: 1e7,
  palette: ['d8d9d9', 'aaaaaa', 'b6dfe9', '2ea3f2', '0c71c3']
};

// plotting the water area per polygon
dataset = dataset.map(function (f) {
  return f.set('AWATER20', ee.Number.parse(f.get('AWATER20')));
});

var image = ee.Image().float().paint(dataset, 'AWATER20');

Map.setCenter(-73.15, 40.9, 9);
Map.addLayer(ee.Image(1), {min:0, max:1}, 'background');
Map.addLayer(image, visParams, 'TIGER/2020/TABBLOCK20');
Map.addLayer(dataset, null, 'for Inspector', false);
