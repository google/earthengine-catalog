var dataset = ee.ImageCollection('UMT/Climate/IrrMapper_RF/v1_1');
var irr = dataset.filterDate('2018-01-01', '2018-12-31').mosaic();
var irr = irr.mask(irr.eq(1));

var visualization = {
  min: 0.0,
  max: 1.0,
  palette: ['blue']
};
Map.addLayer(irr, visualization, 'IrrMapper 2018');
Map.setCenter(-112.516, 45.262, 10);
