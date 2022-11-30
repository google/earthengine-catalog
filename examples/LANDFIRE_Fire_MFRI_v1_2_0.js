var dataset = ee.ImageCollection('LANDFIRE/Fire/MFRI/v1_2_0');

var visualization = {
  bands: ['MFRI'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'MFRI');
