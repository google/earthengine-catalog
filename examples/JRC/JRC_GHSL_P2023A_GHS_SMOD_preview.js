var dataset = ee.Image("JRC/GHSL/P2023A/GHS_SMOD/2030");

var lon = 116;
var lat = 35;

Map.setCenter(lon, lat, 5);

var delta = 3.5;
// Width and height of the thumbnail image.
var pixels = 256;

var smod_code = dataset.select('smod_code');

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};


var image = smod_code.visualize({});

Map.addLayer(image, {}, 'Smod code');

print(ui.Thumbnail({image: image, params: visParams}));