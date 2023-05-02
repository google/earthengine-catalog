var dataset = ee.Image('WRI/GFW/FORMA/thresholds');
var thresholds = dataset.select('delta_bound');
var visParams = {
  min: 0,
  max: 50,
};
Map.setCenter(26, -8, 3);
Map.addLayer(thresholds, visParams, 'Thresholds for FORMA alerts');
