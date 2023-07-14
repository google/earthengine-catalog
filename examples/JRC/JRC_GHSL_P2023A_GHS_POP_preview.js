var dataset = ee.Image("JRC/GHSL/P2023A/GHS_POP");

var lon = 85;
var lat = 25;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

var delta = 3.5;
// Width and height of the thumbnail image.
var pixels = 256;

var population_count = dataset.select('population_count');

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

var palette = ['060606', '337663', '337663', 'ffffff'];

var image = population_count.visualize({palette: palette, min: 0, max:20});

Map.addLayer(image, {}, 'Population count');

print(ui.Thumbnail({image: image, params: visParams}));