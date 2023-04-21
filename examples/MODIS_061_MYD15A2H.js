var collection = ee.ImageCollection('MODIS/061/MYD15A2H')
                  .filterDate('2019-01-01', '2019-10-01');

var colorizedVis = {
  min: 0,
  max: 100,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};

Map.setCenter(-10.88, 40.94, 2);
Map.addLayer(collection.select('Lai_500m'), colorizedVis, 'Lai');
Map.addLayer(collection.select('Fpar_500m'), colorizedVis, 'Fpar');
