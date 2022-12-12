var dataset = ee.Image('JAXA/ALOS/AW3D30/V2_2');
var elevation = dataset.select('AVE_DSM');
var elevationVis = {
  min: -9999,
  max: 15355,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(elevation, elevationVis, 'Elevation');
