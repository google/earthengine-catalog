var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_Water_Area');
var raster = dataset.select('water_area');
var raster_vis = {
  'min': 0.0,
  'palette': [
    'f5f6da',
    '180d02'
  ],
  'max': 0.860558
};
Map.setCenter(79.1, 19.81, 3);
Map.addLayer(raster, raster_vis, 'water_area');

