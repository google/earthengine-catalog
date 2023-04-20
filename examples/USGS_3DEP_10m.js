var dataset = ee.Image('USGS/3DEP/10m')
var elevation = dataset.select('elevation');
var slope = ee.Terrain.slope(elevation);
Map.setCenter(-112.8598, 36.2841, 10);
Map.addLayer(elevation, {min: 0, max: 3000,   palette: [
    '3ae237', 'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13',
    'ff6e08', 'ff500d', 'ff0000', 'de0101', 'c21301', '0602ff', '235cb1',
    '307ef3', '269db1', '30c8e2', '32d3ef', '3be285', '3ff38f', '86e26f'
  ],
}, 'elevation');
Map.addLayer(slope, {min: 0, max: 60}, 'slope');
