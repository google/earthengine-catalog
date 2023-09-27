var dataset = ee.ImageCollection('MODIS/061/MYD13A3')
                  .filter(ee.Filter.date('2020-01-01', '2023-05-01'));
var ndvi = dataset.select('NDVI');
var ndviVis = {
  min: 0,
  max: 9000,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');
