var dataset = ee.ImageCollection('MODIS/MOD09GA_006_NDVI')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var colorized = dataset.select('NDVI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(colorized, colorizedVis, 'Colorized');