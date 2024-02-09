var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_H/2018");
var built = image.select('built_height');
var visParams = {
  min: 0.0,
  max: 0.5,
  palette: ['000000', '400000', 'a00000', '00ffff'],
};
Map.setCenter(74, 31, 8);
Map.addLayer(built, visParams, 'Multitemporal Built-up Height');
