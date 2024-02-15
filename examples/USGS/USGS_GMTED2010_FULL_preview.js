var dataset = ee.Image('USGS/GMTED2010_FULL');

var lon = 17.93;
var lat = 7.71;

// Degrees in EPSG:4326
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var elevation = dataset.select('min');

var elevationVis = {
  min: -100.0,
  max: 6500.0,
  gamma: 3.5,
};

Map.setCenter(lon, lat, 2);
Map.addLayer(elevation, elevationVis, 'Minimum Elevation');

var image = elevation.visualize(elevationVis);

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

Map.addLayer(image, {}, 'Minimum Elevation');

print(ui.Thumbnail({image: image, params: visParams}));
