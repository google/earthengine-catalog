var dataset = ee.FeatureCollection('WWF/HydroSHEDS/v1/FreeFlowingRivers');

// Paint "RIV_ORD" (river order) value to an image for visualization.
var datasetVis = ee.Image().byte().paint(dataset, 'RIV_ORD', 2);

var visParams = {
  min: 1,
  max: 10,
  palette: ['08519c', '3182bd', '6baed6', 'bdd7e7', 'eff3ff']
};

Map.setCenter(-122.348, 45.738, 9);
Map.addLayer(datasetVis, visParams, 'Free flowing rivers');
Map.addLayer(dataset, null, 'FeatureCollection', false);