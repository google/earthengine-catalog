var dataset = ee.ImageCollection('MODIS/MOD09GA_006_NDWI')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var colorized = dataset.select('NDWI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(colorized, colorizedVis, 'Colorized');