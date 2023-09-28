var dataset = ee.ImageCollection('USFS/GTAC/MTBS/annual_burn_severity_mosaics/v1');

var visualization = {
  bands: ['Severity'],
  min: 0,
  max: 6,
  palette:
      ['000000', '006400', '7fffd4', 'ffff00', 'ff0000', '7fff00', 'ffffff']
};

Map.setCenter(-95.712891, 37.09024, 5);

Map.addLayer(dataset, visualization, 'Severity');
