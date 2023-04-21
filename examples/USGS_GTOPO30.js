var dataset = ee.Image('USGS/GTOPO30');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -10.0,
  max: 8000.0,
  gamma: 1.6,
};
Map.setCenter(11.69, 43.9, 4);
Map.addLayer(elevation, elevationVis, 'Elevation');