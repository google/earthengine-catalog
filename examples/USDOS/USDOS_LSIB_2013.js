var dataset = ee.FeatureCollection('USDOS/LSIB/2013');
var visParams = {
  palette: ['f5ff64', 'b5ffb4', 'beeaff', 'ffc0e8', '8e8dff', 'adadad'],
  min: 0.0,
  max: 894.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'iso_num');
Map.setCenter(16.35, 48.83, 4);
Map.addLayer(image, visParams, 'USDOS/LSIB/2013');
Map.addLayer(dataset, null, 'for Inspector', false);
