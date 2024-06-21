var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_EVI')
                  .filterDate('2023-01-01', '2023-03-31');
var colorized = dataset.select('EVI').max();

var colorizedVis = {
  min: 0,
  max: 1,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};

var lon = 9.6568;
var lat = 50.8874;
Map.setCenter(lon, lat, 1);
var delta = 0.05;

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

Map.setCenter(lon, lat, 1);

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));

