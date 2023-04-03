var dataset = ee.Image('JRC/GSW1_0/Metadata');
var detectionsObservations =
    dataset.select(['detections', 'valid_obs', 'total_obs']);
var visParams = {
  min: 100.0,
  max: 900.0,
};
Map.setCenter(4.72, -2.48, 2);
Map.addLayer(detectionsObservations, visParams, 'Detections/Observations');
