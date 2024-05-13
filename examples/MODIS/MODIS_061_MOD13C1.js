var dataset = ee.ImageCollection('MODIS/061/MOD13C1')
                  .filter(ee.Filter.date('2015-01-01', '2015-05-01'));
var ndvi = dataset.select('NDVI');
print(ndvi);
var ndviVis = {
  min: 0,
  max: .9,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');