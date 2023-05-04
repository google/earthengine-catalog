var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP46A1').filter(
  ee.Filter.date('2013-01-01', '2013-07-01'));

// At-sensor Day/night Band radiance (DNB).
var dnb = dataset.select('DNB_At_Sensor_Radiance_500m');
var dnbVis = {
  min: 0,
  max: 50,
  palette: ['black', 'purple', 'cyan', 'green', 'yellow', 'red', 'white'],
};

Map.setCenter(-79.4, 43.1, 8);

Map.addLayer(dnb, dnbVis, 'Day-Night Band (DNB) at sensor radiance 500m');
