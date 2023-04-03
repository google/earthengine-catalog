var dataset = ee.ImageCollection('NOAA/NWS/RTMA')
                  .filter(ee.Filter.date('2018-03-01', '2018-03-02'));
var windSpeed = dataset.select('WIND');
var windSpeedVis = {
  min: 0.0,
  max: 12.0,
  palette: ['001137', '01abab', 'e7eb05', '620500'],
};
Map.setCenter(-95.62, 39.91, 4);
Map.addLayer(windSpeed, windSpeedVis, 'Wind Speed');
