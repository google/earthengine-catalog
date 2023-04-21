var dataset = ee.ImageCollection('NASA/NEX-DCP30')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-30'));
var minimumAirTemperature = dataset.select('tasmin');
var minimumAirTemperatureVis = {
  min: 265.0,
  max: 285.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(-115.356, 38.686, 5);
Map.addLayer(
    minimumAirTemperature, minimumAirTemperatureVis, 'Minimum Air Temperature');
