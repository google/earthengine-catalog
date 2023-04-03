var dataset = ee.FeatureCollection('TIGER/2010/ZCTA5');
var visParams = {
  palette: ['black', 'purple', 'blue', 'green', 'yellow', 'orange', 'red'],
  min: 500000,
  max: 1000000000,
};

var zctaOutlines = ee.Image().float().paint({
  featureCollection: dataset,
  color: 'black',
  width: 1
});

var image = ee.Image().float().paint(dataset, 'ALAND10');
Map.setCenter(-93.8008, 40.7177, 6);
Map.addLayer(image, visParams, 'TIGER/2010/ZCTA5');
Map.addLayer(zctaOutlines, {}, 'borders');
Map.addLayer(dataset, null, 'for Inspector', false);
