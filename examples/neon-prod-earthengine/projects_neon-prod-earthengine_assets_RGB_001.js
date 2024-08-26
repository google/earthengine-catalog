// Read in the NEON AOP RGB Camera Image Collection
var rgb = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/RGB/001");

// Display available images in the RGB/001 Image Collection
print('NEON RGB Camera Images', rgb.aggregate_array('system:index'))

// Specify the start and end dates and filter by date range
var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var rgb2021 = rgb.filterDate(startDate, endDate);

// Filter by NEON site name (see https://www.neonscience.org/field-sites/explore-field-sites)
var rgbABBY_2021 = rgb2021.filter('NEON_SITE == "ABBY"').mosaic();

// Add the RGB Camera layer to the Map and center on the site
Map.addLayer(rgbABBY_2021, {min: 40, max: 200, gamma: 0.65}, 'ABBY 2021 RGB Camera Imagery');
Map.setCenter(-122.341, 45.75, 15);