var dataset = ee.FeatureCollection('USGS/WBD/2017/HUC06');

var visualization = {
  color: '808080',
  strokeWidth: 1
};

dataset = dataset.draw(visualization);

Map.setCenter(-105.861, 39.529, 7);
Map.addLayer(dataset, null, 'Basins');
