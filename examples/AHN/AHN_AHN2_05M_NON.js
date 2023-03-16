var dataset = ee.Image('AHN/AHN2_05M_NON');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -5.0,
  max: 30.0,
};
Map.setCenter(5.80258, 51.78547, 14);
Map.addLayer(elevation, elevationVis, 'Elevation');