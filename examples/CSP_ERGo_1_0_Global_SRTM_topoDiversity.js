var dataset = ee.Image('CSP/ERGo/1_0/Global/SRTM_topoDiversity');
var srtmTopographicDiversity = dataset.select('constant');
var srtmTopographicDiversityVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(-111.313, 39.724, 6);
Map.addLayer(
    srtmTopographicDiversity, srtmTopographicDiversityVis,
    'SRTM Topographic Diversity');
