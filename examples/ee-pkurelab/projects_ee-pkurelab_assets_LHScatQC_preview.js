
// Load QC image with two bands: RMSE and Pearsonr
var LHScat_QC = ee.Image("projects/ee-pkurelab/assets/LHScatQC");

// Select the RMSE and Pearsonr bands from the image
var RMSE = LHScat_QC.select('RMSE');
var Pearsonr = LHScat_QC.select('Pearsonr');

// Visualization parameters
// RMSE visualization: 0–2 (example range, adjust if needed)
var visParams_RMSE = {
  min: 0,
  max: 2,
  palette: ['green', 'yellow', 'red', 'firebrick']
};
// Pearson correlation visualization: -1–1
var visParams_Pearsonr = {
  min: -1,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};


// Define a region roughly covering China for viewing and thumbnail generation
var chinaRegion = ee.Geometry.Rectangle({
  coords: [73.0, 18.0, 135.0, 54.0],   // xmin, ymin, xmax, ymax
  geodesic: false
});

// Center the map on China
Map.centerObject(chinaRegion, 4);


// Add layers to the map

// Add RMSE layer
Map.addLayer(RMSE, visParams_RMSE, 'LHScat QC - RMSE');

// Add Pearsonr layer
Map.addLayer(Pearsonr, visParams_Pearsonr, 'LHScat QC - Pearson r');


// Thumbnail preview script (for catalog / metadata)
// RMSE
var thumb_RMSE = ui.Thumbnail({
  image: RMSE,
  params: {
    min: visParams_RMSE.min,
    max: visParams_RMSE.max,
    palette: visParams_RMSE.palette,
    region: chinaRegion,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-left'}
});

print('Thumbnail preview (RMSE over China):', thumb_RMSE);

//  Pearsonr 
var thumb_Pearsonr = ui.Thumbnail({
  image: Pearsonr,
  params: {
    min: visParams_Pearsonr.min,
    max: visParams_Pearsonr.max,
    palette: visParams_Pearsonr.palette,
    region: chinaRegion,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-right'}
});

print('Thumbnail preview (Pearson r over China):', thumb_Pearsonr);
