var dataset = ee.ImageCollection('NOAA/CDR/SST_WHOI/V2')
                  .filter(ee.Filter.date('2018-03-01', '2018-03-14'));
var seaSurfaceTemperature = dataset.select('sea_surface_temperature');
var visParams = {
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
Map.setCenter(-4.92, -21.09, 2);
Map.addLayer(seaSurfaceTemperature, visParams, 'Sea Surface Temperature');
