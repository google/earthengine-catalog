var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_NDVI')
                  .filterDate('2023-01-01', '2023-01-31');
var colorized = dataset.select('NDVI').max();

var colorizedVis = {
  min: 0,
  max: 1,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(colorized, colorizedVis, 'Colorized');

var lon = 26.73;
var lat = 4.26;
Map.setCenter(lon, lat, 2);
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

Map.addLayer(imageWithBackground, null, 'colorized');

Map.setCenter(6.746, 46.529, 6);

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
