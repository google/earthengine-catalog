var dataset = ee.Image('USGS/GMTED2010_FULL');
var elevation = dataset.select('min');
var elevationVis = {
  min: -100.0,
  max: 6500.0,
  gamma: 3.5,
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(elevation, elevationVis, 'Minimum Elevation');