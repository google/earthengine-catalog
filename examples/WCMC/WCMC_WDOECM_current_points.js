var dataset = ee.FeatureCollection('WCMC/WDOECM/current/points');

dataset = dataset.style({
  color: '0000FF',
  pointSize: 3,
});

Map.setCenter(124.49, 11.63, 6);

Map.addLayer(dataset, {}, 'OECMs points');
