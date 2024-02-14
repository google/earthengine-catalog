var image = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_V/1975');
var built = image.select('built_volume_total');
var visParams = {
  min: 0,
  max: 80000,
  palette: ['000000', '400000', 'a00000', '00ffff'],
};
Map.setCenter(77.156, 28.6532, 10);
Map.addLayer(
    built, visParams,
    'Total (Residential and Non-Residential) Built-up Volume');