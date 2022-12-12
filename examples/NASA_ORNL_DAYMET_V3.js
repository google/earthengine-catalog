var dataset = ee.ImageCollection('NASA/ORNL/DAYMET_V3')
                  .filter(ee.Filter.date('2017-04-01', '2017-04-30'));
var maximumTemperature = dataset.select('tmax');
var maximumTemperatureVis = {
  min: -40.0,
  max: 30.0,
  palette: ['1621A2', 'white', 'cyan', 'green', 'yellow', 'orange', 'red'],
};
Map.setCenter(-110.21, 35.1, 4);
Map.addLayer(maximumTemperature, maximumTemperatureVis, 'Maximum Temperature');
