var image_1975 = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_S/1975');
var built_1975 = image_1975.select('built_surface');
var image_2020 = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_S/2020');
var built_2020 = image_2020.select('built_surface');
var visParams = {min: 0.0, max: 8000.0, palette: ['000000', 'FFFFFF']};

Map.setCenter(77.156, 28.6532, 10);
Map.addLayer(built_1975, visParams, 'Built-up surface [m2], 1975');
Map.addLayer(built_2020, visParams, 'Built-up surface [m2], 2020');
