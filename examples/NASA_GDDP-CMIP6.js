var dataset = ee.ImageCollection('NASA/GDDP-CMIP6')
                  .filter(ee.Filter.date('2014-07-01', '2014-07-02'))
                  .filter(ee.Filter.eq('model', 'ACCESS-CM2'));
var minimumAirTemperature = dataset.select('tasmin');
var minimumAirTemperatureVis = {
  min: 240,
  max: 310,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71, 52, 3);
Map.addLayer(
    minimumAirTemperature, minimumAirTemperatureVis,
    'Minimum Air Temperature (K)');
