var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_Water_Mask');
var raster = dataset.select('water_mask');
var raster_vis = {
  'min': 0.0,
  'palette': [
    '005ce6',
    '00ffc5',
    'bed2ff',
    'aed0f1'
  ],
  'max': 3.0
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(raster, raster_vis, 'water_mask');

