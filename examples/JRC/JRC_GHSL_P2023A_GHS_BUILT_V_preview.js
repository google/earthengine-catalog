var image = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_V/1975');
var lon = 77.156;
var lat = 28.6532;
Map.setCenter(lon, lat, 10);
var delta = 0.3;
// Width and height of the thumbnail image.
var pixels = 256;
var built = image.select('built_volume_total');
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};
var palette = ['000004', '51127c', 'b73779', 'fc8961', 'fcfdbf'];
var image = built.visualize({palette: palette, min: 0, max: 80000});
Map.addLayer(
    image, {}, 'Total (Residential and Non-Residential) Built-up Volume');
print(ui.Thumbnail({image: image, params: visParams}));