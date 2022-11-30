var dataset = ee.ImageCollection('LANDFIRE/Fire/SClass/v1_4_0');

var visualization = {
  bands: ['SClass'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'SClass');
