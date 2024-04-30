var img = ee.Image('UK/NHM/BII/V1/2005').select('b1');
var visParam = {
  palette: ['bbe029', '0a9501', '074b03'],
  max: 1,
  min: 0,
};

var lon = 21.73;
var lat = 2.63;
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.addLayer(img, visParam, 'dtm');
Map.setCenter(lon, lat, 3);

// Degrees in EPSG:27700.
var delta = 30;
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