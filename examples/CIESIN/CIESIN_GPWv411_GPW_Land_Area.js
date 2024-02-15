var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_Land_Area');
var raster = dataset.select('land_area');
var raster_vis = {
  'min': 0.0,
  'palette': [
    'ecefb7',
    '745638'
  ],
  'max': 0.86
};
Map.setCenter(26.4, 19.81, 1);
Map.addLayer(raster, raster_vis, 'land_area');

