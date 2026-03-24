var dataset = ee.ImageCollection('AU/ELVIS/ELVIS_2m');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: 0.0,
  max: 100.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(144.9631, -37.8136, 13);
Map.addLayer(elevation, elevationVis, 'Elevation');
