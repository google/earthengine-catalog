var dataset = ee.ImageCollection('MODIS/MOD09GA_006_NDSI')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var colorized = dataset.select('NDSI');
var colorizedVis = {
  palette: ['000088', '0000FF', '8888FF', 'FFFFFF'],
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(colorized, colorizedVis, 'Colorized');