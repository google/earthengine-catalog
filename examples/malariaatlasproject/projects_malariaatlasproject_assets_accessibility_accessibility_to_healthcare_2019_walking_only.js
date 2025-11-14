var dataset = ee.Image('projects/malariaatlasproject/assets/accessibility/accessibility_to_healthcare/2019_walking_only');
var accessibility = dataset.select('accessibility_walking_only');
var accessibilityVis = {
  min: 0.0,
  max: 41556.0,
  gamma: 4.0,
};
Map.setCenter(18.98, 6.66, 2);
Map.addLayer(accessibility, accessibilityVis, 'Accessibility');
