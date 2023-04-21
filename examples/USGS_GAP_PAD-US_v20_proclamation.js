var dataset = ee.FeatureCollection('USGS/GAP/PAD-US/v20/proclamation');

// Encode "GAP_Sts" (protection level) as a number for visualization.
dataset = dataset.map(function(feature) {
  return feature.set('status', ee.Number.parse(feature.get('GAP_Sts')));
});

// Paint new "status" value to an image for visualization.
var datasetVis = ee.Image().byte().paint(dataset, 'status');

var visualization = {
  min: 1,
  max: 4,
  palette: ['b1a44e', '4eb173', '4e5bb1', 'b14e8c']
};

Map.setCenter(-92.852, 31.549, 8);
Map.addLayer(datasetVis, visualization, 'Protection status');
Map.addLayer(dataset, null, 'FeatureCollection', false);
