var dataset = ee.ImageCollection('LANDFIRE/Fire/FRG/v1_2_0');

var visualization = {
  bands: ['FRG'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'FRG');
