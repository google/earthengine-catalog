
var image = ee.Image(
    'OPERA/DIST/L3_DIST-ANN-HLS/V1/T20LQK_2024_20250430T011326Z'
);
var status = image.select('VEG-DIST-STATUS');
// Values:
// 0: No disturbance detected (forest green)
// 3: Confirmed <50% ongoing disturbance (yellow)
// 6: Confirmed >=50% ongoing disturbance (bright red)
// 7: Confirmed <50% finished disturbance (orange)
// 8: Confirmed >=50% finished disturbance (dark red/crimson)
// 9: Confirmed <50% previous year (tan/light brown)
// 10: Confirmed >=50% previous year (brown)
var statusVis = {
  min: 0,
  max: 10,
  palette: [
    '2e7d32', // 0: No disturbance (forest green)
    '2e7d32',
    '2e7d32',
    'ffeb3b', // 3: Confirmed <50% ongoing (yellow)
    'ff9800',
    'ff5722',
    'f44336', // 6: Confirmed >=50% ongoing (bright red)
    'ff9800', // 7: Confirmed <50% finished (orange)
    'b71c1c', // 8: Confirmed >=50% finished (crimson)
    'd7ccc8', // 9: Confirmed <50% previous year (tan)
    '8d6e63', // 10: Confirmed >=50% previous year (brown)
  ],
};
var visual = status.visualize(statusVis);
var lat = -14.05;
var lon = -60.64;
var delta = 0.45;
var bbox = ee.Geometry.BBox(lon - delta, lat - delta, lon + delta, lat + delta);
var pixels = 256;
var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: bbox,
  crs: 'EPSG:4326',
  format: 'png',
};
print(ui.Thumbnail({image: visual, params: thumbnailParams}));
