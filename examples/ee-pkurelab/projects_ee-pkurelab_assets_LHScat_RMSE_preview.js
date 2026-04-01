
// Load QC image with two bands: RMSE and Pearsonr
var RMSE = ee.Image("projects/ee-pkurelab/assets/LHScat_RMSE");

// Visualization parameters
var visParams_RMSE = {
  min: 0,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

// Thumbnail preview script (for catalog / metadata)
// RMSE
var thumb_RMSE = ui.Thumbnail({
  image: RMSE,
  params: {
    min: visParams_RMSE.min,
    max: visParams_RMSE.max,
    palette: visParams_RMSE.palette,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-left'}
});

print('Thumbnail preview (LHSat RMSE):', thumb_RMSE);
