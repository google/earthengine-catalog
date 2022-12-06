var dataset = ee.FeatureCollection('WWF/HydroSHEDS/v1/Basins/hybas_11');

var visualization = {
  color: '808080',
  strokeWidth: 1
};

dataset = dataset.draw(visualization);

Map.setCenter(-117.731, 53.033, 7);
Map.addLayer(dataset, null, 'Basins');
