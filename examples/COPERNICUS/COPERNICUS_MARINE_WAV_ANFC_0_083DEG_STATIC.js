var dataset = ee.ImageCollection("COPERNICUS/MARINE/WAV/ANFC_0_083DEG_STATIC").first();
var seaFloorDepth = dataset.select('deptho');
var seaFloorDepthVis = {
  min: 0,
  max: 300,
  palette: ['ccccff', '0000ff'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(seaFloorDepth, seaFloorDepthVis, 'Sea Floor Depth');