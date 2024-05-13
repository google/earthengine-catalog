var image = ee.Image("JRC/GHSL/P2023A/GHS_BUILT_C/2018");
var built = image.select('built_characteristics');
Map.setCenter(77.58, 12.97, 13);
Map.addLayer(built, {}, 'Settlement_characteristics (2018)');
