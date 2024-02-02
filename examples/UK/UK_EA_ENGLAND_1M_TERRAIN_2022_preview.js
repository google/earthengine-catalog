var img = ee.Image('UK/EA/ENGLAND_1M_TERRAIN/2022').select('dtm');
var visParam = {
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
  max: 630,
  min: -5,
};

var lon = -2.5;
var lat = 54;
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.addLayer(img, visParam, 'dtm');
Map.setCenter(lon, lat, 5);

// Degrees in EPSG:27700.
var delta = 1;
// Width and height of the thumbnail image.
var pixels = 64;

var image = img.visualize(visParam);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:27700',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));