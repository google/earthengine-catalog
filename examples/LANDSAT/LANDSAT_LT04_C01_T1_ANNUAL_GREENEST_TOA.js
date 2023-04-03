// Import the dataset and mosaic the collection.
var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_ANNUAL_GREENEST_TOA')
                  .mosaic();  // For greater visualization coverage.

// Get the greenness band.
var greenness = dataset.select('greenness');

// Get bands for true color RGB display.
var trueColor = dataset.select(['B3', 'B2', 'B1']);

// Define a mask for low greenness, make low greenness partially transparent.
var mask = dataset.select('greenness').gt(0.1).remap([0, 1], [0.5, 1]);

// Visualization parameters for greenness display.
var greennessVis = {
  min: 0.1,
  max: 0.85,
  palette: ['fffdcd', 'e1cd73', 'aaac20', '5f920c', '187328', '144b2a', '172313']
};

// Visualization parameters for true color display.
var trueColorVis = {
  min: 0.0,
  max: 0.4,
  gamma: 1.2,
};

// Display the layers on the map with mask applied.
Map.setCenter(43.4, 40.0, 7);
Map.addLayer(trueColor.updateMask(mask), trueColorVis, 'True Color (432)', false);
Map.addLayer(greenness.updateMask(mask), greennessVis, 'Greenness');
