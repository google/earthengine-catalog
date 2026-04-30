var dataset = ee.FeatureCollection('WCMC/WDPCA/current/points');

dataset = dataset.style({
  color: '4285F4',
  pointSize: 3,
});

Map.setCenter(24.17, 2.22, 4);

Map.addLayer(dataset, {}, 'Site Points');