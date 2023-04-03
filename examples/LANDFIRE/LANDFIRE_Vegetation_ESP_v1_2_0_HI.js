var dataset = ee.Image('LANDFIRE/Vegetation/ESP/v1_2_0/HI');

var visualization = {
  bands: ['ESP'],
};

Map.setCenter(-155.3, 19.627, 8);

Map.addLayer(dataset, visualization, 'ESP');
