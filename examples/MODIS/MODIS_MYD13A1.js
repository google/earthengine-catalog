var dataset = ee.ImageCollection('MODIS/MYD13A1')
                  .filter(ee.Filter.date('2014-04-01', '2014-06-01'));
var ndvi = dataset.select('NDVI');
var ndviVis = {
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');
