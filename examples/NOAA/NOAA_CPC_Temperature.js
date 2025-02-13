var dataset = ee.ImageCollection('NOAA/CPC/Temperature').filter(ee.Filter.date('2018-01-01', '2019-01-01'));
var temperature = dataset.select('tmax');
var temperatureVis = {
  min: -40,
  max: 50,
  palette: ['#ADD8E6', '#008000', '#FFFF00', '#FFA500', '#FF0000', '#800080'],
};
Map.setCenter(-104.8, 49.1, 3);
Map.addLayer(temperature, temperatureVis, 'NOAA CPC Temperature');
