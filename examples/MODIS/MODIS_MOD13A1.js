var dataset = ee.ImageCollection('MODIS/MOD13A1')
                  .filter(ee.Filter.date('2014-04-01', '2014-06-01'));
var ndvi = dataset.select('NDVI');
var ndviVis = {
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};
Map.setCenter(-7.03, 31.05, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');
