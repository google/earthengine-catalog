var dataset = ee.Image('LANDFIRE/Vegetation/ESP/v1_2_0/AK');

var visualization = {
  bands: ['ESP'],
};

Map.setCenter(-151.011, 63.427, 8);

Map.addLayer(dataset, visualization, 'ESP');
