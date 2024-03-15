var dataset = ee.FeatureCollection('WM/geoLab/geoBoundaries/600/ADM0');


var empty_image = ee.Image().byte();

// Paint all the polygon edges with the same number and width, display.
var boundary = empty_image.paint({
  featureCollection: dataset,
  color: 1,
  width: 3
});


var boundary_vis = {
  palette: ['000000'],
};

var lon = -100.0;
var lat = 38.5;
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(
  boundary,
  boundary_vis,
  'ADM0 Boundaries');

// Degrees in EPSG:4326.
var lat_delta = 30;
var lon_delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;

var image = boundary.visualize(boundary_vis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
