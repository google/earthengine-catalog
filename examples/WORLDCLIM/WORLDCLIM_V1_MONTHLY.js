var dataset = ee.ImageCollection('WORLDCLIM/V1/MONTHLY');
var meanTemperature = dataset.select('tavg').first().multiply(0.1);
var meanTemperatureVis = {
  min: -40,
  max: 30,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.7, 52.4, 3);
Map.addLayer(meanTemperature, meanTemperatureVis, 'Mean Temperature');
