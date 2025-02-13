var dataset = ee.ImageCollection('UCSB-CHG/CHIRTS/DAILY')
                  .filter(ee.Filter.date('2016-05-01', '2016-05-03'));
var maximumTemperature = dataset.select('maximum_temperature');
var visParams = {
  min: 10,
  max: 30,
  palette: ['darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red','darkred'],
};
Map.setCenter(-104.28, 46.07, 3);
Map.addLayer(maximumTemperature, visParams, 'Maximum temperature');