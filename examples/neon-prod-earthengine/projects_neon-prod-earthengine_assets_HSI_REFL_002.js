var refl002 = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/HSI_REFL/002");

var startDate = ee.Date('2022-01-01');
var endDate = startDate.advance(1, 'year');
var refl001_2022 = refl002.filterDate(startDate, endDate);

var liro2022 = refl001_2022.filter('NEON_SITE == "LIRO"').mosaic();

// extract the red, green, and blue bands for a true-color image
var liro2022_refl_rgb = liro2022.select(['B053', 'B035', 'B019'])

var rgb_viz = {min: 340, max: 2150, gamma: 2}
Map.setCenter(-89.70, 46.01, 16);
Map.addLayer(liro2022_refl_rgb, rgb_viz, 'LIRO 2022 Bidirectional Reflectance RGB Image');
