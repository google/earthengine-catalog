// Load the RMSE (Root Mean Square Error) band 
var RMSE = ee.Image("projects/ee-pkurelab/assets/LHScat_RMSE");

// Define visualization parameters for RMSE
var visParams_RMSE = {
  min: 0,
  max: 1,
  palette: ['#C7E9C0', '#FFD966', '#FFB347', '#E29578']
};

// Center the map view 
Map.centerObject(RMSE, 1);

// Add the RMSE layer to the map with specified visualization
Map.addLayer(RMSE, visParams_RMSE, 'LHScat QC - RMSE');