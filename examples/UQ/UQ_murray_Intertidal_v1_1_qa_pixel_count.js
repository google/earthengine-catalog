var dataset = ee.ImageCollection('UQ/murray/Intertidal/v1_1/qa_pixel_count');

var visualization = {
  bands: ['pixel_count'],
  min: 0,
  max: 300,
  palette: ['000000', 'ffffff']
};

Map.setCenter(126.6339, 37.4394, 10);

Map.addLayer(dataset, visualization, 'QA Pixel Count');
