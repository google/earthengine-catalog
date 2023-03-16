var dataset = ee.FeatureCollection('JRC/GWIS/GlobFire/v2/FinalPerimeters');
var visParams = {
  palette: ['f5ff64', 'b5ffb4', 'beeaff', 'ffc0e8', '8e8dff', 'adadad'],
  min: 0.0,
  max: 600000000.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'area');
Map.addLayer(image, visParams, 'GlobFire Final');
Map.addLayer(dataset, null, 'for Inspector', false);
Map.setCenter(-122.121, 38.56, 12)
