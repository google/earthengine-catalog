var dsm = ee.ImageCollection('projects/neon-prod-earthengine/assets/DP3-30024-001')
  .filterDate('2021-01-01', '2021-12-31')
  .filterMetadata('NEON_SITE', 'equals', 'SOAP')
  .filterMetadata('PRODUCT_TYPE', 'equals', 'DSM');

var dtm = ee.ImageCollection('projects/neon-prod-earthengine/assets/DP3-30024-001')
  .filterDate('2021-01-01', '2021-12-31')
  .filterMetadata('NEON_SITE', 'equals', 'SOAP')
  .filterMetadata('PRODUCT_TYPE', 'equals', 'DTM');

var demVis = {min: 600, max: 2300, gamma: 0.5};
Map.setCenter(-119.25, 37.06, 12);
Map.addLayer(dsm, demVis, 'SOAP 2021 Digital Surface Model');
Map.addLayer(dtm, demVis, 'SOAP 2021 Digital Terrain Model');
