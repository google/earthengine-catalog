// Read in the NEON AOP Directional Reflectance Image Collection
var refl001 = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/HSI_REFL/001");

// Display available images in the HSI_REFL/001 Image Collection
print('NEON Directional Reflectance Images', refl001.aggregate_array('system:index'))

// Specify the start and end dates and filter by dates
var startDate = ee.Date('2017-01-01');
var endDate = startDate.advance(1, 'year');
var refl001_2017 = refl001.filterDate(startDate, endDate);

// Filter by NEON site name (see https://www.neonscience.org/field-sites/explore-field-sites)
var reflGRSM_2017 = refl001_2017.filter('NEON_SITE == "GRSM"').mosaic();

// Define the visualization parameters, display the red, green, and blue bands for a true-color image
var rgbVis = {min: 340, max: 2150, bands: ['B053','B035','B019'], gamma: 2}

// Add the reflectance layer to the Map and center on the site
Map.addLayer(reflGRSM_2017, rgbVis, 'GRSM 2017 Directional Reflectance RGB Image');
Map.setCenter(-83.5, 35.65, 14);