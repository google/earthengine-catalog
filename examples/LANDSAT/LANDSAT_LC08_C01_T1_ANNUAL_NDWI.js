var dataset = ee.ImageCollection('LANDSAT/LC08/C01/T1_ANNUAL_NDWI')
                  .filterDate('2017-01-01', '2017-12-31');
var colorized = dataset.select('NDWI');
var colorizedVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');
