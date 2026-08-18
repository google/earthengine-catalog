var lon = 89.2;
var lat = 21.9;

var delta = 0.7;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var dataset = ee.FeatureCollection('projects/mangrovedatahub2/assets/CGMD-Extent30');

var extent2023 = dataset
  .filter(ee.Filter.eq('year', 2023))
  .filterBounds(areaOfInterest);

var image = ee.Image().byte().paint({
  featureCollection: extent2023,
  color: 1
}).visualize({
  palette: ['#00fc00'],
  forceRgbOutput: true
});

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));