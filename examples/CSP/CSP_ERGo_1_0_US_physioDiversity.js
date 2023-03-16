var dataset = ee.Image('CSP/ERGo/1_0/US/physioDiversity');
var physiographicDiversity = dataset.select('b1');
var physiographicDiversityVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(-94.625, 39.825, 7);
Map.addLayer(
    physiographicDiversity, physiographicDiversityVis,
    'Physiographic Diversity');
