var dataset = ee.ImageCollection('CIESIN/GPWv411/GPW_National_Identifier_Grid');
var raster = dataset.select('national_identifier_grid');
var raster_vis = {
  'min': 4.0,
  'palette': [
    '000000',
    'ffffff'
  ],
  'max': 999.0
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(raster, raster_vis, 'national_identifier_grid');

