var dataset = ee.ImageCollection('WORLDCLIM/V1/MONTHLY');
var meanTemperature = dataset.select('tavg');
var meanTemperatureVis = {
  min: -400.0,
  max: 300.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(meanTemperature, meanTemperatureVis, 'Mean Temperature');
