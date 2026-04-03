
// Load QC image with two bands: RMSE and Pearsonr
var LHScat_QC = ee.Image("projects/ee-pkurelab/assets/LHScatQC");

// Select the RMSE and Pearsonr bands from the image
var RMSE = LHScat_QC.select('RMSE');
var Pearsonr = LHScat_QC.select('Pearsonr');

// Visualization parameters
// RMSE visualization: 0–2 (example range, adjust if needed)
var visParams_RMSE = {
  min: 0,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};
// Pearson correlation visualization: -1–1
var visParams_Pearsonr = {
  min: 0.8,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};


// Define a bbox
var region = ee.Geometry.Rectangle([73, 18, 150, 54]);
Map.centerObject(region, 4);


// Add layers to the map

// Add RMSE layer
Map.addLayer(RMSE, visParams_RMSE, 'LHScat QC - RMSE');

// Add Pearsonr layer
Map.addLayer(Pearsonr, visParams_Pearsonr, 'LHScat QC - Pearson r');


