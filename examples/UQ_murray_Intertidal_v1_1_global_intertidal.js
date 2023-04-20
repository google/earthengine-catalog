var dataset = ee.ImageCollection('UQ/murray/Intertidal/v1_1/global_intertidal');

var visualization = {
  bands: ['classification'],
  min: 0.0,
  max: 1.0,
  palette: ['0000FF']
};

Map.setCenter(126.6339, 37.4394, 10);

Map.addLayer(dataset, visualization, 'Intertidal areas');
