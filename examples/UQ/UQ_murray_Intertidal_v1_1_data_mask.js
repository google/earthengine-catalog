var dataset = ee.Image('UQ/murray/Intertidal/v1_1/data_mask');

var visualization = {
  bands: ['datamask'],
  min: 0.0,
  max: 1.0,
  palette: ['000000', 'FFFFFF']
};

Map.setCenter(126.6339, 37.4394, 10);

Map.addLayer(dataset, visualization, 'Data mask');
