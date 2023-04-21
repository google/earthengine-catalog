var dataset = ee.ImageCollection('NASA/NEX-GDDP')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-02'));
var minimumAirTemperature = dataset.select('tasmin');
var minimumAirTemperatureVis = {
  min: 240.0,
  max: 300.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(
    minimumAirTemperature, minimumAirTemperatureVis, 'Minimum Air Temperature');
