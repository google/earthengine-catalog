var analytic = ee.Image("GOOGLE/BRAZIL_FOREST_2008/V1/ANALYTIC");

var lon = -55.0;
var lat = -10.0;
var delta = 0.05;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['N', 'R', 'G'],
  min: 0,
  max: 0.8
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var background = ee.Image.rgb(0, 0, 0);
var sampleImage = analytic.visualize(visParams);
var raster_image = ee.ImageCollection([background, sampleImage]).mosaic();

print(ui.Thumbnail({image: raster_image, params: imageParams}));
