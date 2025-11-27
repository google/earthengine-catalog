var dataset = ee.FeatureCollection('JRC/LUCAS/THLOC/V1/2022');

// For the Inspector
Map.addLayer(dataset, {}, 'LUCAS Points (data)', false);

dataset = dataset.style({
  color: '489734',
  pointSize: 3,
});

Map.setCenter(-6.0, 37.0, 10);

Map.addLayer(dataset, {}, 'LUCAS 2022 Points');
