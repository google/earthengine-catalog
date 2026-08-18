// var aoi = ee.Geometry.Point(-56.57, -9.8756);
// var image = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1')
//   .filter(ee.Filter.eq('satellite', 'SPOT5'))
//   .filterBounds(aoi)
//   .first();
// Map.centerObject(image);
// Map.addLayer(image);
// print(image);

var image = ee.Image(
  'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1/003-007-S5-689-370-0-2009-07-11-13-54-39-HRG-2-J-DT-GU');

var lon = -56.57;
var lat = -9.8756;
var delta = 0.1;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['N', 'R', 'G'],
  min: 55,
  max: 210,
  gamma: 0.95
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: image.visualize(visParams), params: imageParams}));
