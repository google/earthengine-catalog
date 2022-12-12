var dataset = ee.ImageCollection('NOAA/CFSV2/FOR6H')
                  .filter(ee.Filter.date('2018-03-01', '2018-03-14'));
var temperatureAboveGround = dataset.select('Temperature_height_above_ground');
var visParams = {
  min: 220.0,
  max: 310.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(temperatureAboveGround, visParams, 'Temperature Above Ground');
