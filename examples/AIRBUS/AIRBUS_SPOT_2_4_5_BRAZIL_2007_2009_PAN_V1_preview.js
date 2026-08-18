// var aoi = ee.Geometry.Point(-56.57, -9.8756);
// var image = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PAN/V1')
//   .filter(ee.Filter.eq('satellite', 'SPOT5'))
//   .filterBounds(aoi)
//   .first();
// Map.centerObject(image);
// Map.addLayer(image);
// print(image);

var image = ee.Image(
  'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PAN/V1/4136530');

var lon = -56.57;
var lat = -9.8756;
var delta = 0.1;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['P'],
  min: 65,
  max: 172,
  gamma: 1.2
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: image.visualize(visParams), params: imageParams}));
