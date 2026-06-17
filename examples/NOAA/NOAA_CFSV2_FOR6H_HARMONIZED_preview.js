var dataset = ee.ImageCollection('NOAA/CFSV2/FOR6H_HARMONIZED')
                  .filter(ee.Filter.date('2018-03-01', '2018-03-14'));
var temperatureAboveGround = dataset.select('Temperature_height_above_ground').mean();
var visParams = {
  min: 220.0,
  max: 310.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};

var lon = -80;
var lat = 10;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(temperatureAboveGround, visParams, 'Mean temperature height above ground');

// Degrees in EPSG:3857.
var delta = 60;
// Width and height of the thumbnail image.
var pixels = 256;

var image = temperatureAboveGround.visualize(visParams);
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
