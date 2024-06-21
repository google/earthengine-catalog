var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_NDWI')
                  .filterDate('2023-02-01', '2023-03-01');
var colorized = dataset.select('NDWI').max();

var colorizedVis = {
  min: 0.9,
  max: 1.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(6.746, 46.529, 6);
var lon = 8.86;
var lat = 58.32;
// Map.setCenter(lon, lat, 2);
var delta = 1;

var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var backGround = ee.Image.constant(1).visualize({palette:['808080'],min:0,max:1})


var image1 = colorized.visualize(colorizedVis);

var imageWithBackground = ee.ImageCollection([backGround,image1]).mosaic();

Map.addLayer(imageWithBackground, null, 'Colorized');

Map.setCenter(6.746, 46.529, 6);

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));

