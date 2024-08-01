var rgb = ee.ImageCollection(
  "projects/neon-prod-earthengine/assets/RGB/001");

var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var rgb2021 = rgb.filterDate(startDate, endDate);

var abby2021 = rgb2021.filter('NEON_SITE == "ABBY"').mosaic();

var rgbVis = {min: 40, max: 200, gamma: 0.65};
Map.setCenter(-122.341, 45.75, 16);
Map.addLayer(abby2021, rgbVis, 'ABBY 2021 RGB Camera Imagery');
