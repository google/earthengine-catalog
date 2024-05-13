var dataset = ee.ImageCollection('UMT/Climate/IrrMapper_RF/v1_2');
var irr = dataset.filterDate('2023-01-01', '2023-12-31').mosaic();

var visualization = {
  min: 0.0,
  max: 1.0,
  palette: ['blue']
};
Map.addLayer(irr, visualization, 'IrrMapper 2023');
Map.setCenter(-112.516, 45.262, 10);
