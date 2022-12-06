var dataset = ee.Image('NOAA/NGDC/ETOPO1');
var elevation = dataset.select('bedrock');
var elevationVis = {
  min: -7000.0,
  max: 3000.0,
  palette: ['011de2', 'afafaf', '3603ff', 'fff477', 'b42109'],
};
Map.setCenter(-37.62, 25.8, 2);
Map.addLayer(elevation, elevationVis, 'Elevation');