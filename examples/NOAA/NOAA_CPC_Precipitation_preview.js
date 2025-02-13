var dataset = ee.ImageCollection('NOAA/CPC/Precipitation')
                  .filter(ee.Filter.date('2018-01-01', '2019-01-01'));
var temp = dataset.select('precipitation').mean();
var tempVis = {
  min: 0,
  max: 150,
  palette: ['#ADD8E6', '#008000', '#FFFF00', '#FFA500', '#FF0000', '#800080'],
};

var lon = -68.36;
var lat = -6.73;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(temp, tempVis, 'precipitation');

// Degrees in EPSG:3857.
var delta = 25;
// Width and height of the thumbnail image.
var pixels = 256;

var image = temp.visualize(tempVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};


print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
