var dataset = ee.Image('Estonia/Maamet/orthos/rgb/53454_OF_RGB_GeoTIFF_1999_53454');

var lon = 24.959;
var lat = 58.148;

Map.setCenter(lon, lat, 18);

// Degrees in EPSG:4326
var lon_delta = 0.002;
var lat_delta = 0.001;
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

Map.addLayer(image, {}, 'Estonia rgb');

print(ui.Thumbnail({image: image, params: visParams}));
