var collection = ee.ImageCollection('MODIS/061/MOD15A2H')
                  .filterDate('2019-01-01', '2019-10-01');

var colorizedVis = {
  min: 0,
  max: 100,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};

Map.setCenter(-10.88, 40.94, 2);
Map.addLayer(collection.select('Lai_500m'), colorizedVis, 'Lai');
Map.addLayer(collection.select('Fpar_500m'), colorizedVis, 'Fpar');
