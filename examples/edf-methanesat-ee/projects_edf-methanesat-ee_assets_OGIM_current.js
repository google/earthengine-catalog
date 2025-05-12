var dataset = ee.FeatureCollection("projects/edf-methanesat-ee/assets/OGIM/current");

var datasetVis = dataset.style({
  color: 'black',
  fillColor: 'yellow',
  pointSize: 2,
  width: 0.5
});

Map.setCenter(-96, 40, 4);
Map.setOptions("SATELLITE");
Map.addLayer(datasetVis, {}, 'oil and gas infrastructure');
