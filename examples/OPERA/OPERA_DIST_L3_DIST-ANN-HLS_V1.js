var dataset = ee.ImageCollection('OPERA/DIST/L3_DIST-ANN-HLS/V1')
    .filterDate('2025-01-01', '2026-01-01');

var dist = dataset.select('VEG-DIST-STATUS').mosaic();

Map.setCenter(29.81, 2.02, 11);

var statusVis = {
  min: 0,
  max: 10,
  palette: [
    '121212', // 0: No disturbance detected (dark)
    '000000', // Not used
    '000000', // Not used
    'dee043', // 3: Confirmed <50% ongoing disturbance (yellow)
    '000000', // Not used
    '000000', // Not used
    'e01b07', // 6: Confirmed >=50% ongoing disturbance (red)
    '777777', // 7: Confirmed <50% finished disturbance (gray)
    'dddddd', // 8: Confirmed >=50% finished disturbance (very light gray)
    '333333', // 9: Confirmed <50% disturbance from previous year (darkest gray)
    '444444', // 10: Confirmed >=50% disturbance from previous year (dark gray)
  ],
};

Map.addLayer(dist, statusVis, 'Vegetation Disturbance Status');
