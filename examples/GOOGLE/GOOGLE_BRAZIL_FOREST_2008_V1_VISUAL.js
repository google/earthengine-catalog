// To access this dataset, fill out the form: https://forms.gle/jQmCbWgarjENQBYz6

var visual2008 = ee.Image("GOOGLE/BRAZIL_FOREST_2008/V1/VISUAL");

// Define visualization parameters
var visParams = {
  bands: ['R', 'G', 'B'],
  min: 0,
  max: 255
};

// Center the map on a high-priority conservation area in Brazil
Map.setCenter(-55.0, -10.0, 6);

// Add the 2008 imagery. Gaps will appear transparent,
// showing the Map's default satellite background.
Map.addLayer(visual2008, visParams, 'Brazil Forest Code 2008 (Visual)');
