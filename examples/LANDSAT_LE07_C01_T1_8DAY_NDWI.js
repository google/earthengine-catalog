var dataset = ee.ImageCollection('LANDSAT/LE07/C01/T1_8DAY_NDWI')
                  .filterDate('1999-01-01', '2002-12-31');
var colorized = dataset.select('NDWI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
