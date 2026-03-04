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

// Read in the uncertainty band
var cnc_uncertainty = cnc_harv2019.select('Nitrogen_Uncertainty');

// Define the visualization parameters
// Note: The min/max values below use a 98% stretch
var visParamsNit = {bands: ['Nitrogen_Percent'], min: 1.38, max: 2.76, palette: ['#440154', '#3b528b', '#21908c', '#5dc963', '#fde725']};
var visParamsUnc = {min: 0.44, max: 1.5, palette: ['#0d0887', '#7e03a8', '#cc4778', '#f89540', '#f0f921']}; 

// Add the nitrogen and uncertainty layers to the map and center on the site
// Note that the masked areas in the nitrogen layer have higher uncertainty
Map.addLayer(cnc_uncertainty, visParamsUnc, 'HARV 2019 Nitrogen Uncertainty (%)');
Map.addLayer(cnc_masked, visParamsNit, 'HARV 2019 Nitrogen (%)');