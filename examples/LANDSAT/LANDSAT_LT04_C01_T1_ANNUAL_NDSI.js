var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_ANNUAL_NDSI')
                  .filterDate('1989-01-01', '1992-12-31');
var colorized = dataset.select('NDSI');
var colorizedVis = {
  palette: ['000088', '0000ff', '8888ff', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
