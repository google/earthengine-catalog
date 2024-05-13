var dataset = ee.ImageCollection('WRI/Aqueduct_Flood_Hazard_Maps/V2');
var inundationDepth = dataset.select('inundation_depth');
var inundationDepthVis = {
  min: 0,
  max: 1,
  palette: ['ffffff','0000ff'],
};
Map.setCenter(-68.36, -6.73, 4);
Map.addLayer(inundationDepth, inundationDepthVis, 'Aqueduct Flood Hazard Maps');
