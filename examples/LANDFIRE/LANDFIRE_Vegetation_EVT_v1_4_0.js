var dataset = ee.ImageCollection('LANDFIRE/Vegetation/EVT/v1_4_0');

var visualization = {
  bands: ['EVT'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'EVT');
