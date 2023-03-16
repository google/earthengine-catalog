var dataset = ee.ImageCollection('MODIS/061/MOD13Q1')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var ndvi = dataset.select('NDVI');
var ndviVis = {
  min: 0.0,
  max: 8000.0,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');
