// Read in the NEON AOP DEM Image Collection
var dem = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/DEM/001');
  
// Display available images in the DEM/001 Image Collection
print('NEON DEM Images', dem.aggregate_array('system:index'))

// Specify the start and end dates and filter by date range
var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var dem2021 = dem.filterDate(startDate, endDate);

// Filter by NEON site name (see https://www.neonscience.org/field-sites/explore-field-sites)
var demSOAP_2021 = dem2021.filter('NEON_SITE == "SOAP"');
  
// Select the DTM and DSM bands in order to display each layer
var soapDTM = dem2021.select('DTM');
var soapDSM = dem2021.select('DSM');

// Define the color palette and visualization parameters
var palettes = require('users/gena/packages:palettes');
var dem_palette = palettes.colorbrewer.BrBG[9].reverse();
var demVis = {min: 700, max: 2300, palette: dem_palette};

// Add the DTM and DSM layers and center on the site
Map.addLayer(soapDTM, demVis, 'SOAP 2021 Digital Terrain Model (m)');
Map.addLayer(soapDSM, demVis, 'SOAP 2021 Digital Surface Model (m)');
Map.setCenter(-119.25, 37.06, 12);