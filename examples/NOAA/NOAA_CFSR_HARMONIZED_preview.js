var dataset = ee.ImageCollection('NOAA/CFSR_HARMONIZED')
                  .filter(ee.Filter.date('2019-04-01', '2019-04-07'));
var temperatureSurface = dataset.select('Temperature_surface').mean();
var visParams = {
  min: 192,
  max: 339,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

var lon = -80;
var lat = 10;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(temperatureSurface, visParams, 'Mean temperature surface');

// Degrees in EPSG:3857.
var delta = 60;
// Width and height of the thumbnail image.
var pixels = 256;

var image = temperatureSurface.visualize(visParams);
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
