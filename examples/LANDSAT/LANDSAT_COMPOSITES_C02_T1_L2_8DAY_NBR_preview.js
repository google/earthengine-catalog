var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_8DAY_NBR')
                  .filterDate('2023-01-01', '2023-01-31');
var colorized = dataset.select('NBR').max();

var colorizedVis = {
  min: 0.9,
  max: 1.0,
  palette: ['000000', 'ffffff'],
};

Map.setCenter(21.6, -18, 8);
var lon = 20.2583;
var lat = -17.4649;

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

Map.setCenter(21.6, -18, 8);

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));

