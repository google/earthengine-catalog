var dataset = ee.Image('Estonia/Maamet/orthos/mono/54953_OF_RGB_GeoTIFF_1995_54953');

var lon = 26.61312;
var lat = 58.5879;

Map.setCenter(lon, lat, 15);

// Degrees in EPSG:4326
var lon_delta = 0.02;
var lat_delta = 0.01;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var image = dataset.visualize({min: 0, max: 256});

Map.addLayer(image, {}, 'Estonia mono');

print(ui.Thumbnail({image: image, params: visParams}));
