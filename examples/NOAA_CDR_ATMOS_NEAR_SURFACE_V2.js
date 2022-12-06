var dataset = ee.ImageCollection('NOAA/CDR/ATMOS_NEAR_SURFACE/V2')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-02'));
var airTemperature = dataset.select('air_temperature');
var airTemperatureVis = {
  min: 0.0,
  max: 30.0,
  palette: [
    '040274', '040281', '0502a3', '0502b8', '0502ce', '0502e6',
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef',
    '3be285', '3ff38f', '86e26f', '3ae237', 'b5e22e', 'd6e21f',
    'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08', 'ff500d',
    'ff0000', 'de0101', 'c21301', 'a71001', '911003'
  ],
};
Map.setCenter(28.3, -28.1, 1);
Map.addLayer(airTemperature, airTemperatureVis, 'Air Temperature');
