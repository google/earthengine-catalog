var dataset = ee.ImageCollection('LANDFIRE/Fire/PRS/v1_2_0');

var visualization = {
  bands: ['PRS'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'PRS');
