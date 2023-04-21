var dataset = ee.ImageCollection('LANDSAT/LT05/C01/T1_32DAY_NDSI')
                  .filterDate('2011-01-01', '2011-12-31');
var colorized = dataset.select('NDSI');
var colorizedVis = {
  palette: ['000088', '0000FF', '8888FF', 'FFFFFF'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
