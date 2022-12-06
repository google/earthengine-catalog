var dataset = ee.FeatureCollection('GLIMS/current');
var visParams = {
  palette: ['gray', 'cyan', 'blue'],
  min: 0.0,
  max: 10.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'area');
Map.setCenter(-35.618, 66.743, 7);
Map.addLayer(image, visParams, 'GLIMS/current');
Map.addLayer(dataset, null, 'for Inspector', false);
