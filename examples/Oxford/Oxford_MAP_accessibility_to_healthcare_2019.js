var dataset = ee.Image('Oxford/MAP/accessibility_to_healthcare_2019');
var accessibility = dataset.select('accessibility');
var accessibilityVis = {
  min: 0.0,
  max: 41556.0,
  gamma: 4.0,
};
Map.setCenter(18.98, 6.66, 2);
Map.addLayer(accessibility, accessibilityVis, 'Accessibility');
