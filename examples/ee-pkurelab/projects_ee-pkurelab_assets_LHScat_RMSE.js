// Load the RMSE (Root Mean Square Error) band 
var RMSE = ee.Image("projects/ee-pkurelab/assets/LHScat_RMSE");

// Define visualization parameters for RMSE
var visParams_RMSE = {
  min: 0,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

// Center the map view 
Map.centerObject(RMSE, 1);

// Add the RMSE layer to the map with specified visualization
Map.addLayer(RMSE, visParams_RMSE, 'LHScat QC - RMSE');