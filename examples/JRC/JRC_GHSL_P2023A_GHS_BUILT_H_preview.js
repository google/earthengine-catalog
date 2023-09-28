var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_H/2018");
var lon = 74;
var lat = 31;
Map.setCenter(lon, lat, 8);
var delta = 3.5;
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
var palette = ['000000', '400000', 'a00000', '00ffff'];
var image = built.visualize({palette: palette, min: 0, max:0.5});
Map.addLayer(image, {}, 'Multitemporal Built-up Height');
print(ui.Thumbnail({image: image, params: visParams}));
