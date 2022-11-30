var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_32DAY_NBRT')
                  .filterDate('1989-01-01', '1992-12-31');
var colorized = dataset.select('NBRT');
var colorizedVis = {
  min: 0.9,
  max: 1.0,
  palette: ['000000', 'FFFFFF'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
