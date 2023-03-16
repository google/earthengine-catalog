var coll = ee.ImageCollection('FAO/SOFO/1/FPP');
var image = coll.first().select('FPP_1km');
Map.setCenter(17.5, 20, 3);
Map.addLayer(
    image, {min: 0, max: 12, palette: ['blue', 'yellow', 'red']},
    'Forest proximate people – 1km cutoff distance');
