var dataset = ee.FeatureCollection('WCMC/WDPA/current/points');

dataset = dataset.style({
  color: '4285F4',
  pointSize: 3,
});

Map.setCenter(110.57, 0.88, 4);

Map.addLayer(dataset, {}, 'Protected Area Points');
