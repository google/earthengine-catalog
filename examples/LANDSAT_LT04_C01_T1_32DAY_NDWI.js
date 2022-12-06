var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_32DAY_NDWI')
                  .filterDate('1989-01-01', '1992-12-31');
var colorized = dataset.select('NDWI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
