var dataset = ee.ImageCollection('LANDFIRE/Fire/PLS/v1_2_0');

var visualization = {
  bands: ['PLS'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'PLS');
