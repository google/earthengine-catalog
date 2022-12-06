var dataset = ee.ImageCollection('LANDFIRE/Fire/VDep/v1_4_0');

var visualization = {
  bands: ['VDep'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'VDep');
