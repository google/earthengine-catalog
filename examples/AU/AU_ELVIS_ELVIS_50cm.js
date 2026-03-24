var dataset = ee.ImageCollection('AU/ELVIS/ELVIS_50cm');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: 0.0,
  max: 100.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(149.1287, -35.2820, 15);
Map.addLayer(elevation, elevationVis, 'Elevation');
