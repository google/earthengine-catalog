var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_C/2018");
var lon = 77.58;
var lat = 12.97;
Map.setCenter(lon, lat, 13);
var delta = 0.1;
// Width and height of the thumbnail image.
var pixels = 256;
var built = image.select('built_characteristics');
var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

Map.addLayer(built, {}, 'Multitemporal Built-up Characteristics');
print(ui.Thumbnail({image: built.visualize(), params: visParams}));