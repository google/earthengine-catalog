var dataset = ee.ImageCollection('NOAA/GFS0P25')
                  .filter(ee.Filter.date('2018-03-01', '2018-03-02'));
var temperatureAboveGround = dataset.select('temperature_2m_above_ground');
var visParams = {
  min: -40.0,
  max: 35.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(temperatureAboveGround, visParams, 'Temperature Above Ground');
