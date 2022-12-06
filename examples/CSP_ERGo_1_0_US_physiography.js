var dataset = ee.Image('CSP/ERGo/1_0/US/physiography');
var physiography = dataset.select('constant');
var physiographyVis = {
  min: 1100.0,
  max: 4220.0,
};
Map.setCenter(-105.4248, 40.5242, 8);
Map.addLayer(physiography, physiographyVis, 'Physiography');
