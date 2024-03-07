var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_H/2018");
var built = image.select('built_height');
var visParams = {
  min: 0.0,
  max: 12.0,
  palette: ['000000', '0d0887', '7e03a8', 'cc4778', 'f89540', 'f0f921'],
};

Map.setCenter(2.349014, 48.864716, 10);
Map.addLayer(built, visParams, 'Average building height [m], 2018');