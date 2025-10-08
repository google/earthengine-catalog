var dataset = ee.ImageCollection("COPERNICUS/MARINE/WAV/ANFC_0_083DEG_STATIC").first();
var seaFloorDepth = dataset.select('deptho');
var seaFloorDepthVis = {
  min: 100,
  max: 700,
  palette: ['000080', '0000d0', '0000ff', '87ceeb', 'ffffff'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(seaFloorDepth, seaFloorDepthVis, 'Sea Floor Depth');