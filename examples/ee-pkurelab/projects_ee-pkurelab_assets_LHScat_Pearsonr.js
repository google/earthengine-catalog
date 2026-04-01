// Load the Pearson correlation coefficient image 
var Pearsonr = ee.Image("projects/ee-pkurelab/assets/LHScat_Pearsonr");

// Define visualization parameters for the Pearson correlation coefficient
var visParams_Pearsonr = {
  min: 0.8,
  max: 1,
  palette: ['#C7E9C0', '#FFD966', '#FFB347', '#E29578']
};

// Center the map view
Map.centerObject(Pearsonr, 1);

// Add the Pearson correlation coefficient layer to the map
Map.addLayer(Pearsonr, visParams_Pearsonr, 'LHScat Pearson r');