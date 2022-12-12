var dataset = ee.ImageCollection('IDAHO_EPSCOR/PDSI')
                  .filter(ee.Filter.date('2018-07-01', '2018-08-01'));
var pdsi = dataset.select('pdsi');
var pdsiVis = {
  min: -5.0,
  max: 10.0,
  palette: ['red', 'yellow', 'green', 'cyan', 'blue'],
};
Map.setCenter(-115.356, 38.686, 5);
Map.addLayer(pdsi, pdsiVis, 'PDSI');
