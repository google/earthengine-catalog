var dataset = ee.Image('AHN/AHN2_05M_RUW');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -5.0,
  max: 30.0,
};
Map.setCenter(5.76583, 51.855276, 16);
Map.addLayer(elevation, elevationVis, 'Elevation');
