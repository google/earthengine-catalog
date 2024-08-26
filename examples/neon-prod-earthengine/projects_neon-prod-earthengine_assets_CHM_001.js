// Read in the NEON AOP CHM Image Collection
var chm = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/CHM/001');

// Display available images in the CHM Image Collection
print('NEON CHM Images', chm.aggregate_array('system:index'))

// Specify the start and end dates and filter by dates
var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var chm2021 = chm.filterDate(startDate, endDate);

// Filter by NEON site name (see https://www.neonscience.org/field-sites/explore-field-sites)
var soapCHM = chm2021.filter('NEON_SITE == "SOAP"');

// Define the visualization parameters, using a green color palette
var chmVis = {min: 0, max: 35, palette: ['E6F7E0', '063B00']};

// Add the CHM layer to the Map and center on the site
Map.addLayer(soapCHM, chmVis, 'SOAP 2021 Canopy Height Model (m)');
Map.setCenter(-119.25, 37.06, 12);
