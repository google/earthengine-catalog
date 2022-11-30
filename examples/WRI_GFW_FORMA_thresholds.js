var dataset = ee.Image('WRI/GFW/FORMA/thresholds');
var thresholds = dataset.select('delta_bound');
var visParams = {
  min: 0.0,
  max: 50.0,
};
Map.setCenter(25.73, -7.61, 2);
Map.addLayer(thresholds, visParams, 'Thresholds for FORMA alerts');
