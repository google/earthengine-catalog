var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_NBR')
                  .filterDate('2017-01-01', '2017-12-31');
var colorized = dataset.select('NBR');
var colorizedVis = {
  min: 0.9,
  max: 1.0,
  palette: ['000000', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
