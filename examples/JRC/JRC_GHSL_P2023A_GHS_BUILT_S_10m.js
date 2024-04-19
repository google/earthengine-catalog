var image_2018 = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_S_10m/2018');
var built_2018 = image_2018.select('built_surface');
var visParams = {min: 0.0, max: 100.0, palette: ['000000', 'FFFFFF']};

Map.setCenter(77.156, 28.6532, 10);
Map.addLayer(built_2018, visParams, 'Built-up surface [m2], 2018');
