var dataset = ee.ImageCollection('AU/GA/AUSTRALIA_5M_DEM');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: 0.0,
  max: 150.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(140.1883, -35.9113, 8);
Map.addLayer(elevation, elevationVis, 'Elevation');
