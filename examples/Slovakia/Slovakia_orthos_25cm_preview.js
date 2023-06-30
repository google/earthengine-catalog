var dataset = ee.Image('Slovakia/orthos/25cm/2018_BANSKA_BYSTRICA_6_3');

var lon = 19.163;
var lat = 48.751;

Map.setCenter(lon, lat, 18);

// Degrees in EPSG:4156
var delta = 0.001;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Since there was slight tilt while using EPSG:3857, we are using EPSG:4156
//  https://epsg.io/4156
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4156',
  format: 'png',
};

var image = dataset.visualize({min: 0, max: 256});

Map.addLayer(image, {}, 'Slovakia RGB');

print(ui.Thumbnail({image: image, params: visParams}));
