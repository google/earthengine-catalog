var dataset = ee.ImageCollection('COPERNICUS/DEM/GLO30');
var elevation = dataset.select('DEM');
var elevationVis = {
  min: 0.0,
  max: 1000.0,
  palette: ['0000ff','00ffff','ffff00','ff0000','ffffff'],
};
Map.setCenter(-6.746, 46.529, 4);
Map.addLayer(elevation, elevationVis, 'DEM');
