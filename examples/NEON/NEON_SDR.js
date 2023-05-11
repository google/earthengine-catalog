var sdr = ee.ImageCollection('projects/neon-prod-earthengine/assets/DP3-30006-001')
  .filterDate('2019-01-01', '2019-12-31')
  .filterMetadata('NEON_SITE', 'equals', 'HARV');

var sdr_rgb = sdr.select(['B053', 'B035', 'B019']);
var rgbVis = {min: 103, max: 1160, gamma: 1};
Map.setCenter(-72.20, 42.50, 11);
Map.addLayer(sdr_rgb, rgbVis, 'HARV 2019 Surface Directional Reflectance RGB');
