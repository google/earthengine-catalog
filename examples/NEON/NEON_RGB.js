var camera = ee.ImageCollection('projects/neon-prod-earthengine/assets/DP3-30010-001')
  .filterDate('2021-01-01', '2021-12-31')
  .filterMetadata('NEON_SITE', 'equals', 'ABBY');

var rgb = camera.select(['B1', 'B2', 'B3']);
var rgbVis = {min: 40, max: 200, gamma: 0.5};
Map.setCenter(-122.32, 45.75, 12);
Map.addLayer(rgb, rgbVis, 'ABBY 2021 RGB Camera Imagery');
