var dataset = ee.Image('NOAA/VIIRS/DNB/ANNUAL_V22/20220101');

var lon = -77;
var lat = 30;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

// Degrees in EPSG:4326
var delta = 15;
// Width and height of the thumbnail image.
var pixels = 256;

var average_radiance = dataset.select('average');

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};


var image = average_radiance.visualize({});

Map.addLayer(image, {}, 'Average Radiance');

print(ui.Thumbnail({image: image, params: visParams}));
