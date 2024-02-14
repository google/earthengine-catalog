var dataset = ee.FeatureCollection("EDF/OGIM/OGIM_v2-4_RF06_RF08");

var datasetVis = dataset.style({
  color: 'black',
  pointSize: 3,
});

// Center on one of the two available areas of interests.
// Map.setCenter(-109.6, 40, 9);
Map.setCenter(-103.71, 31.96, 9);
Map.setOptions("SATELLITE");
Map.addLayer(datasetVis, {}, 'oil and gas infrastructure')
