var collection = ee.ImageCollection("AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1");

var lon = -45.2603;
var lat = -19.5429;
var delta = 0.02;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  bands: ['B3', 'B2', 'B1'],
  min: 0,
  max: 200
};

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var background = ee.Image.rgb(0, 0, 0);
var sampleImage = collection.filterBounds(areaOfInterest).mosaic().visualize(visParams);
var raster_image = ee.ImageCollection([background, sampleImage]).mosaic();

print(ui.Thumbnail({image: raster_image, params: imageParams}));
