var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_H/2018");
var lon = 2.349014;
var lat = 48.864716;
Map.setCenter(lon, lat, 10);
var delta = 0.5;
// Width and height of the thumbnail image.
var pixels = 256;
var built = image.select('built_height');
var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};
var palette = ['000000', '0d0887', '7e03a8', 'cc4778', 'f89540', 'f0f921'];
var image = built.visualize({palette: palette, min: 0, max: 12});
Map.addLayer(image, {}, 'Multitemporal Built-up Height');
print(ui.Thumbnail({image: image, params: visParams}));
