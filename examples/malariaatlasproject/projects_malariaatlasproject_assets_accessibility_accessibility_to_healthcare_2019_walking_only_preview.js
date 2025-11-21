var dataset = ee.Image('projects/malariaatlasproject/assets/accessibility/accessibility_to_healthcare/2019_walking_only');
var accessibility = dataset.select('accessibility_walking_only');
var accessibilityVis = {
  min: 0.0,
  max: 41556.0,
  gamma: 4.0,
};
Map.setCenter(18.98, 6.66, 2);
Map.addLayer(accessibility, accessibilityVis, 'Accessibility');

var areaOfInterest = ee.Geometry.Rectangle(
  [-20, -40, 100, 80], null, false);

var pixels = 256;
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});

var image = accessibility.visualize(accessibilityVis);
var imageWithBg = background.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: parameters}));