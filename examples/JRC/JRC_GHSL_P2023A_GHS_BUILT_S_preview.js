var dataset = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_S/2030");

var lon = 75;
var lat = 28;

Map.setCenter(lon, lat, 8);

var delta = 3.5;
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

var palette = ['000000', '400000', 'a00000', '00ffff'];

var image = built.visualize({palette: palette, min: 0, max:100});

Map.addLayer(image, {}, 'Multitemporal built-up Surface');

var image = built.visualize({palette: palette, min: 0, max:100});

print(ui.Thumbnail({image: image, params: visParams}));
