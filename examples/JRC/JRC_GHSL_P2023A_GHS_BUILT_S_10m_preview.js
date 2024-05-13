var dataset = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_S_10m/2018");

var lon = 77.156;
var lat = 28.6532;

Map.setCenter(lon, lat, 10);

var delta = 0.2;
// Width and height of the thumbnail image.
var pixels = 256;

var built = dataset.select('built_surface');

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

var palette = ['000000', 'FFFFFF'];

var image = built.visualize({palette: palette, min: 0, max: 100});

Map.addLayer(image, {}, 'Multitemporal built-up Surface');

print(ui.Thumbnail({image: image, params: visParams}));
