var dataset = ee.ImageCollection('OPERA/DIST/L3_DIST-ANN-HLS/V1')
    .filterDate('2025-01-01', '2026-01-01');

var anompal = [
  '000000',
  '400013',
  '800026',
  'bd0026',
  'e31a1c',
  'fc4e2a',
  'fd8d3c',
  'feb24c',
  'fed976',
  'ffeda0',
  'ffffcc',
];

var lon = -112.07;
var lat = 36.4;
var radius = 25000;
var bounds = ee.Geometry.Point([lon, lat]).buffer(radius).bounds();

var image = dataset.select('VEG-ANOM-MAX').mosaic().visualize({
  min: 0,
  max: 100,
  palette: anompal,
});

var thumbnailParams = {
  dimensions: [256, 256],
  region: bounds,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: image, params: thumbnailParams}));
