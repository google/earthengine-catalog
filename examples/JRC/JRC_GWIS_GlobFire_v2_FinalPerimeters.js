var dataset = ee.FeatureCollection('JRC/GWIS/GlobFire/v2/FinalPerimeters');

var computeArea = function(f) {
  return f.set({'area': f.area()});
};

var features = dataset.map(computeArea).filter(ee.Filter.lt('area', 1e11));

var visParams = {
  palette: ['f5ff64', 'b5ffb4', 'beeaff', 'ffc0e8', '8e8dff', 'adadad'],
  min: 0,
  max: 600000000,
  opacity: 0.8,
};
var image = ee.Image().float().paint(features, 'area');
Map.addLayer(image, visParams, 'GlobFire Final');
Map.addLayer(features, null, 'for Inspector', false);
Map.setCenter(-122.121, 38.56, 12);
