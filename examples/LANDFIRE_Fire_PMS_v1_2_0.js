var dataset = ee.ImageCollection('LANDFIRE/Fire/PMS/v1_2_0');

var visualization = {
  bands: ['PMS'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'PMS');
