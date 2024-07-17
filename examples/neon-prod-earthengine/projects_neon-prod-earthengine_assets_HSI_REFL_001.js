var refl001 = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/HSI_REFL/001");

var startDate = ee.Date('2017-01-01');
var endDate = startDate.advance(1, 'year');
var refl001_2017 = refl001.filterDate(startDate, endDate);

var grsm2017 = refl001_2017.filter('NEON_SITE == "GRSM"').mosaic();

// extract the red, green, and blue bands for a true-color image
var grsm2017_refl_rgb = grsm2017.select(['B053', 'B035', 'B019'])

var rgb_viz = {min: 340, max: 2150, gamma: 2}

Map.setCenter(-83.5, 35.65, 14);
Map.addLayer(grsm2017_refl_rgb, rgb_viz, 'GRSM 2017 Reflectance RGB Image');
