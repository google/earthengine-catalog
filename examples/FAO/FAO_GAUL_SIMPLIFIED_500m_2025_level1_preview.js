var lon = 7.82;
var lat = 49.1;
var lat_delta = 10;
var lon_delta = 15;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var dataset = ee.FeatureCollection('FAO/GAUL_SIMPLIFIED_500m/2025/level1');

var styled = dataset.style({
  color: '00909F',
  fillColor: 'b5ffb4',
  width: 1.0,
});

var gray = 250;
var background = ee.Image.rgb(gray, gray, gray);
var image = background.blend(styled);

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: image, params: imageParams}));
