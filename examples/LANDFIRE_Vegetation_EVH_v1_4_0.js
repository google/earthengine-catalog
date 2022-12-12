var dataset = ee.ImageCollection('LANDFIRE/Vegetation/EVH/v1_4_0');

var visualization = {
  bands: ['EVH'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'EVH');
