var image = ee.Image("JRC/GHSL/P2023A/GHS_SMOD/2030");
var smod = image.select('smod_code');
var visParams = {
  min: 0.0,
  max: 30.0,
  palette: ['000000', '200000', '70daa4', 'ffffff'],
};
Map.setCenter(84, 25, 5);
Map.addLayer(image, visParams, 'Degree of Urbanization');
