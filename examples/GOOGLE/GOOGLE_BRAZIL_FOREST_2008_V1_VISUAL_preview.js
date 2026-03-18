var visual2008 = ee.Image("GOOGLE/BRAZIL_FOREST_2008/V1/VISUAL");

var lon = -55.0;
var lat = -10.0;
var delta = 0.05;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['R', 'G', 'B'],
  min: 0,
  max: 255
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var background = ee.Image.rgb(0, 0, 0);
var sampleImage = visual2008.visualize(visParams);
var raster_image = ee.ImageCollection([background, sampleImage]).mosaic();

print(ui.Thumbnail({image: raster_image, params: imageParams}));
