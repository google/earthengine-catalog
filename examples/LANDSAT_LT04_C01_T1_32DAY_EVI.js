var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_32DAY_EVI')
                  .filterDate('1989-01-01', '1992-12-31');
var colorized = dataset.select('EVI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
