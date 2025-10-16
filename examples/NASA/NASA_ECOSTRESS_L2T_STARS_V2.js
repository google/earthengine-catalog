var dataset = ee.ImageCollection('NASA/ECOSTRESS/L2T_STARS/V2')
                  .filter(ee.Filter.date('2025-03-01', '2025-05-01'));
var NDVI = dataset.select('NDVI').mean();

var vis = {
  min: -1.0,
  max: 1.0,
  palette: ['00008B', 'A9A9A9', 'CD853F', 'FFFF00', '90EE90', '006400'],
};

Map.setCenter(-77.1056, 38.8904, 10);
Map.addLayer(NDVI, vis, 'NDVI');