var dataset = ee.Image('OSU/GIMP/DEM');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: 0.0,
  max: 2000.0,
};
Map.setCenter(-41.0, 76.0, 4);
Map.addLayer(elevation, elevationVis, 'Elevation');