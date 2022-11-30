var dataset = ee.Image('NASA/ASTER_GED/AG100_003');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -15.0,
  max: 5000.0,
  palette: [
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};
Map.setCenter(89.12, 37.72, 3);
Map.addLayer(elevation, elevationVis, 'Elevation');