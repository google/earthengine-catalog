var dataset = ee.ImageCollection('NASA/NEX-DCP30_ENSEMBLE_STATS')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-30'));
var monthlyMeanMinimumAirTemperature = dataset.select('tasmin_mean');
var monthlyMeanMinimumAirTemperatureVis = {
  min: 247.0,
  max: 311.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(-115.356, 38.686, 5);
Map.addLayer(
    monthlyMeanMinimumAirTemperature, monthlyMeanMinimumAirTemperatureVis,
    'Monthly Mean Minimum Air Temperature');
