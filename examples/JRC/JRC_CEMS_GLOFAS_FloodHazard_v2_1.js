var dataset = ee.ImageCollection('JRC/CEMS_GLOFAS/FloodHazard/v2_1');
var depth = dataset.select('RP100_depth');
var depthVis = {
  min: 0,
  max: 1,
  palette: ['ffffff','0000ff'],
};
Map.setCenter(-86.47, 47.28, 4);
Map.addLayer(depth, depthVis, 'JRC Flood Hazard Maps V2.1');