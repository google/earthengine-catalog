var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_Mean_Administrative_Unit_Area');
var raster = dataset.select('mean_administrative_unit_area');
var raster_vis = {
  'min': 0.0,
  'palette': [
    'ffffff',
    '747474',
    '656565',
    '3c3c3c',
    '2f2f2f',
    '000000'
  ],
  'max': 40000.0
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(raster, raster_vis, 'mean_administrative_unit_area');

