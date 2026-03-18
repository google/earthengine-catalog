var collection = ee.ImageCollection("AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PMS_NC/V1");

var lon = -45.2603;
var lat = -19.5429;
var delta = 0.02;
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
var sampleImage = collection.filterBounds(areaOfInterest).mosaic();
sampleImage = sampleImage.updateMask(sampleImage.select('cloud_mask').not()).visualize(visParams);
var raster_image = ee.ImageCollection([background, sampleImage]).mosaic();

print(ui.Thumbnail({image: raster_image, params: imageParams}));
