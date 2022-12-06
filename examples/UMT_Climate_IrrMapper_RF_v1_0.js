var dataset = ee.ImageCollection("UMT/Climate/IrrMapper_RF/v1_0");
var irr_2013 = dataset.filterDate('2013-01-01', '2013-12-31').select('classification');

var visualization = {
  min: 0.0,
  max: 1.0,
  palette: ['blue']
};
Map.addLayer(irr_2013, visualization, 'IrrMapper 2013');
Map.setCenter(-112.516, 45.262, 10);
