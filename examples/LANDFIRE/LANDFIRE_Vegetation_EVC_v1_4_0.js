var dataset = ee.ImageCollection('LANDFIRE/Vegetation/EVC/v1_4_0');

var visualization = {
  bands: ['EVC'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'EVC');
