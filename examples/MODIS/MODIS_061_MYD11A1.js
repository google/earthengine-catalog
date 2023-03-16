var dataset = ee.ImageCollection('MODIS/061/MYD11A1')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var landSurfaceTemperature = dataset.select('LST_Day_1km');
var landSurfaceTemperatureVis = {
  min: 13000.0,
  max: 16500.0,
  palette: [
    '040274', '040281', '0502a3', '0502b8', '0502ce', '0502e6',
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef',
    '3be285', '3ff38f', '86e26f', '3ae237', 'b5e22e', 'd6e21f',
    'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08', 'ff500d',
    'ff0000', 'de0101', 'c21301', 'a71001', '911003'
  ],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    landSurfaceTemperature, landSurfaceTemperatureVis,
    'Land Surface Temperature');
