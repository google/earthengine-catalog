var dataset = ee.Image('CSP/ERGo/1_0/Global/ALOS_topoDiversity');
var alosTopographicDiversity = dataset.select('constant');
var alosTopographicDiversityVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(-111.313, 39.724, 6);
Map.addLayer(
    alosTopographicDiversity, alosTopographicDiversityVis,
    'ALOS Topographic Diversity');
