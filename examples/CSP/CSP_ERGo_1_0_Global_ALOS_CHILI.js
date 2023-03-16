var dataset = ee.Image('CSP/ERGo/1_0/Global/ALOS_CHILI');
var alosChili = dataset.select('constant');
var alosChiliVis = {
  min: 0.0,
  max: 255.0,
};
Map.setCenter(-105.8636, 40.3439, 11);
Map.addLayer(alosChili, alosChiliVis, 'ALOS CHILI');
