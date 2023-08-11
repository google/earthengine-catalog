var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_S/2030");
var built = image.select('built_surface');
var visParams = {
  min: 0.0,
  max: 30.0,
  palette: ['000000', '400000', 'a00000', '00ffff'],
};
Map.setCenter(75, 28, 8);
Map.addLayer(built, visParams, 'Multitemporal built-up Surface');
