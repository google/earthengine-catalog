
// Load the Pearson correlation coefficient image 
var Pearsonr = ee.Image("projects/ee-pkurelab/assets/LHScat_Pearsonr");

// Visualization parameters
var visParams_Pearsonr = {
  min: 0.8,
  max: 1,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

//  Pearsonr 
var thumb_Pearsonr = ui.Thumbnail({
  image: Pearsonr,
  params: {
    min: visParams_Pearsonr.min,
    max: visParams_Pearsonr.max,
    palette: visParams_Pearsonr.palette,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-right'}
});

print('Thumbnail preview (LHSat Pearson r):', thumb_Pearsonr);
