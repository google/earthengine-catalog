var dataset = ee.ImageCollection('NOAA/CFSR')
                  .filter(ee.Filter.date('2019-04-01', '2019-04-07'));
var temperatureSurface = dataset.select('Temperature_surface');
var visParams = {
  min: 192.0,
  max: 339.0,
  palette: ["blue", "purple", "cyan", "green", "yellow", "red"]
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(temperatureSurface, visParams, 'Temperature Surface');
