var dataset = ee.ImageCollection('OPERA/DIST/L3_DIST-ANN-HLS/V1')
    .filterDate('2024-01-01', '2025-01-01');

var dist = dataset.select('VEG-DIST-STATUS').mosaic();

Map.setCenter(-60.64, -14.05, 9);

var statusVis = {
  min: 0,
  max: 10,
  palette: [
    '2e7d32', // 0: No disturbance detected (forest green)
    '2e7d32',
    '2e7d32',
    'ffeb3b', // 3: Confirmed <50% ongoing disturbance (yellow)
    'ff9800',
    'ff5722',
    'f44336', // 6: Confirmed >=50% ongoing disturbance (bright red)
    'ff9800', // 7: Confirmed <50% finished disturbance (orange)
    'b71c1c', // 8: Confirmed >=50% finished disturbance (crimson)
    'd7ccc8', // 9: Confirmed <50% disturbance from previous year (tan)
    '8d6e63', // 10: Confirmed >=50% disturbance from previous year (brown)
  ],
};

Map.addLayer(dist, statusVis, 'Vegetation Disturbance Status');
