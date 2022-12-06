var dataset = ee.Image('LANDFIRE/Vegetation/ESP/v1_2_0/CONUS');

var visualization = {
  bands: ['ESP'],
};

Map.setCenter(-121.671, 40.699, 5);

Map.addLayer(dataset, visualization, 'ESP');
