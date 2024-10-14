var image = ee.Image("JRC/GHSL/P2023A/GHS_SMOD_V2-0/2030");
var smod = image.select('smod_code');
Map.setCenter(84, 25, 5);
Map.addLayer(image, {}, 'Degree of Urbanization');
