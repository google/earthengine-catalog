// var aoi = ee.Geometry.Point(-56.56, -9.8756);
// var image = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PMS_NC/V1')
//   .filter(ee.Filter.eq('satellite', 'SPOT5'))
//   .filterBounds(aoi)
//   .first();
// Map.centerObject(image);
// Map.addLayer(image);
// print(image);

var image = ee.Image(
  'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PMS_NC/V1/4136530');

var lon = -56.57;
var lat = -9.8756;
var delta = 0.1;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['R','G','B'],
  min: 48.14,
  max: 150.86,
  gamma: 0.867
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: image.visualize(visParams), params: imageParams}));
