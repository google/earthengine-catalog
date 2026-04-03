
// Load QC image with two bands: RMSE and Pearsonr
var LHScat_QC = ee.Image("projects/ee-pkurelab/assets/LHScatQC");

// Select the RMSE and Pearsonr bands from the image
var RMSE = LHScat_QC.select('RMSE');

// Visualization parameters
// RMSE visualization: 0–2 (example range, adjust if needed)
var visParams_RMSE = {
  min: 0,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

// Define a bbox
var region = ee.Geometry.Rectangle([73, 8, 150, 54]);

// RMSE
var thumb_RMSE = ui.Thumbnail({
  image: RMSE,
  params: {
    min: visParams_RMSE.min,
    max: visParams_RMSE.max,
    palette: visParams_RMSE.palette,
    region: region,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-left'}
});

print('Thumbnail preview (RMSE):', thumb_RMSE);

