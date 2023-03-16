var dataset = ee.ImageCollection('LANDSAT/LE07/C01/T1_8DAY_NDSI')
                  .filterDate('1999-01-01', '2002-12-31');
var colorized = dataset.select('NDSI');
var colorizedVis = {
  palette: ['000088', '0000FF', '8888FF', 'FFFFFF'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
