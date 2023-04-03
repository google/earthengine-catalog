var dataset = ee.Image('WWF/HydroSHEDS/15CONDEM');
var elevation = dataset.select('b1');
var elevationVis = {
  min: -50.0,
  max: 3000.0,
  gamma: 2.0,
};
Map.setCenter(-121.652, 38.022, 8);
Map.addLayer(elevation, elevationVis, 'Elevation');