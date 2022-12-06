var dataset = ee.ImageCollection('NOAA/CDR/OISST/V2')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-14'));
var seaSurfaceTemperature = dataset.select('sst');
var visParams = {
  min: -180.0,
  max: 3000.0,
  palette: [
    '040274', '040281', '0502a3', '0502b8', '0502ce', '0502e6',
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef',
    '3be285', '3ff38f', '86e26f', '3ae237', 'b5e22e', 'd6e21f',
    'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08', 'ff500d',
    'ff0000', 'de0101', 'c21301', 'a71001', '911003'
  ],
};
Map.setCenter(20.3, -20.39, 2);
Map.addLayer(seaSurfaceTemperature, visParams, 'Sea Surface Temperature');
