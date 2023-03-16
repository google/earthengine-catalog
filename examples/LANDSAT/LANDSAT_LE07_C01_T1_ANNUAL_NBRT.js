var dataset = ee.ImageCollection('LANDSAT/LE07/C01/T1_ANNUAL_NBRT')
                  .filterDate('1999-01-01', '2002-12-31');
var colorized = dataset.select('NBRT');
var colorizedVis = {
  min: 0.9,
  max: 1.0,
  palette: ['000000', 'FFFFFF'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
