var image = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_S_10m/2018');
var built_total = image.select('built_surface');
var built_nres = image.select('built_surface_nres');
built_nres = built_nres.updateMask(built_nres.gt(0));

var visParams = {min: 0.0, max: 100.0, palette: ['000000', 'FFFFFF']};

Map.setCenter(31.23, 30.05, 12);
Map.addLayer(built_total, visParams, 'Built-up surface [m^2], 2018');
Map.addLayer(
    built_nres, {palette: ['magenta']},
    'Non-residential built-up surface, 2018');
