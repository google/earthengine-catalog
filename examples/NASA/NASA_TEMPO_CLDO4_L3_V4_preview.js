var visParams = {
  min: 0,
  max: 1,
  bands: ['cloud_fraction'],
};

// thumbnail location
var lon = -86.73;
var lat = 42.60;

//Background
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var delta = 10;
var pixels = 256;

var collection = ee.ImageCollection('NASA/TEMPO/CLDO4_L3_V4')
    .filterDate('2024-04-01', '2024-04-05');
var image = collection.mosaic().visualize(visParams);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Specify the thumbnail parameters.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
Map.setCenter(lon, lat, 3)
Map.addLayer(imageWithBackground, {}, 'Cloud Fraction')
