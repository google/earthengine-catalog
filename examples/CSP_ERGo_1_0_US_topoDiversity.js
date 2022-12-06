var dataset = ee.Image('CSP/ERGo/1_0/US/topoDiversity');
var usTopographicDiversity = dataset.select('constant');
var usTopographicDiversityVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(-111.313, 39.724, 6);
Map.addLayer(
    usTopographicDiversity, usTopographicDiversityVis,
    'US Topographic Diversity');
