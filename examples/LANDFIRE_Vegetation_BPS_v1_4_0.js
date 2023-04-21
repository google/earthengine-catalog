var dataset = ee.ImageCollection('LANDFIRE/Vegetation/BPS/v1_4_0');

var visualization = {
  bands: ['BPS'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'BPS');
