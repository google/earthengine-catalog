var camera = ee.ImageCollection(
    "projects/neon-prod-earthengine/assets/DP3-30010-001");
  
  var startDate = ee.Date('2021-01-01');
  var endDate = startDate.advance(1, 'year');
  var camera2021 = camera.filterDate(startDate, endDate);
  
  var abbyCamera2021 = camera2021.filter('NEON_SITE == "ABBY"').mosaic();
  
  var rgbVis = {min: 40, max: 200, gamma: 0.65};
  Map.setCenter(-122.341, 45.75, 12);
  Map.addLayer(abbyCamera2021, rgbVis, 'ABBY 2021 RGB Camera Imagery');
  