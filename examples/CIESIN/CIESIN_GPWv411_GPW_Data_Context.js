var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_Data_Context');
var raster = dataset.select('data_context');
var raster_vis = {
  'min': 200.0,
  'palette': [
    'ffffff',
    '099506',
    'f04923',
    'e62440',
    '706984',
    'a5a5a5',
    'ffe152',
    'd4cc11',
    '000000'
  ],
  'max': 207.0
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(raster, raster_vis, 'data_context');

