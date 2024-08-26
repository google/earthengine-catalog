// Read in the NEON AOP Bidirectional Reflectance Image Collection
var refl002 = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/HSI_REFL/002");

// Display available images in the HSI_REFL/002 Image Collection
print('NEON Bidirectional Reflectance Images', refl002.aggregate_array('system:index'))

// Specify the start and end dates and filter by date range
var startDate = ee.Date('2022-01-01');
var endDate = startDate.advance(1, 'year');
var refl002_2022 = refl002.filterDate(startDate, endDate);

// Filter by NEON site name (see https://www.neonscience.org/field-sites/explore-field-sites)
var reflLIRO_2022 = refl002_2022.filter('NEON_SITE == "LIRO"').mosaic();

// Define the visualization parameters, display the red, green, and blue bands for a true-color image
var rgbVis = {min: 340, max: 2150, bands: ['B053','B035','B019'], gamma: 2}

// Add the reflectance layer to the Map and center on the site
Map.addLayer(reflLIRO_2022, rgbVis, 'LIRO 2022 Bidirectional Reflectance');
Map.setCenter(-89.70, 46.01, 14);