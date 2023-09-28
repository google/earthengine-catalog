var dataset = ee.ImageCollection('MODIS/MYD09GA_006_NDSI')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var colorized = dataset.select('NDSI');
var colorizedVis = {
  palette: ['000088', '0000ff', '8888ff', 'ffffff'],
};
Map.setCenter(-7.03, 31.05, 2);
Map.addLayer(colorized, colorizedVis, 'Colorized');
