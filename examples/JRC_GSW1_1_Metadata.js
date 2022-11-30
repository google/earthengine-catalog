var dataset = ee.Image('JRC/GSW1_1/Metadata');

var visualization = {
  bands: ['detections', 'valid_obs', 'total_obs'],
  min: 100.0,
  max: 900.0,
};

Map.setCenter(71.72, 52.48, 0);

Map.addLayer(dataset, visualization, 'Detections/Observations');
