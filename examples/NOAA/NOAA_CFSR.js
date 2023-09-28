var dataset = ee.ImageCollection('NOAA/CFSR')
                  .filter(ee.Filter.date('2019-04-01', '2019-04-07'));
var temperatureSurface = dataset.select('Temperature_surface');
var visParams = {
  min: 192,
  max: 339,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

var soilType = dataset.select('Soil_type_surface');
var soilTypeVisParams = {
  min: 1,
  max: 9,
  palette: [
    'red', 'orange', 'blue', 'yellow', 'violet',
    'magenta', 'cadetblue', 'pink', 'aquamarine',]
}
Map.addLayer(
    soilType, soilTypeVisParams, 'Soil type at the surface', true, 0.6);
Map.addLayer(
    temperatureSurface, visParams, 'Temperature at surface (K)', true, 0.6);

Map.setCenter(-88.6, 26.4, 2);
