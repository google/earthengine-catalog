var dataset = ee.Image('AU/GA/DEM_1SEC/v10/DEM-S');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -10.0,
  max: 1300.0,
  palette: [
    '3ae237', 'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13',
    'ff6e08', 'ff500d', 'ff0000', 'de0101', 'c21301', '0602ff', '235cb1',
    '307ef3', '269db1', '30c8e2', '32d3ef', '3be285', '3ff38f', '86e26f'
  ],
};
Map.setCenter(133.95, -24.69, 5);
Map.addLayer(elevation, elevationVis, 'Elevation');
