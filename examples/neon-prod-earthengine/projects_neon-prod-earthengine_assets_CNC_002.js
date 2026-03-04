// Read in the NEON AOP CNC Image Collection
var cnc = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/CNC/002');

// Display available images in the CNC Image Collection
print('NEON Canopy Nitrogen Images')
print(cnc.aggregate_array('system:index'))

// Filter by specific image index
var cnc_harv2019 = cnc.filter(ee.Filter.eq('system:index', '2019_HARV_6')).first();

// Mask nitrogen band using valid pixel band
var cnc_valid = cnc_harv2019.select('Valid_Pixel_Classification');
var cnc_masked = cnc_harv2019.updateMask(cnc_valid);

// Read in the uncertainty band and mask using valid pixel band
var cnc_unc = cnc_harv2019.select('Nitrogen_Uncertainty');
var cnc_unc_masked = cnc_unc.updateMask(cnc_valid);

// Define the visualization parameters
// The min/max values below use a 2 sigma (~95%) stretch
var visParamsNit = {bands: ['Nitrogen_Percent'], min: 1.6, max: 2.14, palette: ['#440154', '#3b528b', '#21908c', '#5dc963', '#fde725']};
var visParamsUnc = {min: 0.4, max: 0.7, palette: ['#0d0887', '#7e03a8', '#cc4778', '#f89540', '#f0f921']};

// Add the masked nitrogen and uncertainty layers to the map and center on the site
Map.addLayer(cnc_unc_masked, visParamsUnc, 'HARV 2019 Nitrogen Uncertainty (%)');
Map.addLayer(cnc_masked, visParamsNit, 'HARV 2019 Nitrogen (%)');
Map.centerObject(cnc_harv2019, 11);