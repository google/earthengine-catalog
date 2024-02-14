var dataset = ee.Image('Netherlands/Beeldmateriaal/LUCHTFOTO_RGB/2021_165000_433000_RGB_hrl');

var lon = 5.54;
var lat = 51.88;

Map.setCenter(lon, lat, 18);

// Degrees in EPSG:4326
var delta = 0.001;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var image = dataset.visualize({min: 0, max: 256});

Map.addLayer(image, {}, 'Netherlands RGB');

print(ui.Thumbnail({image: image, params: visParams}));
