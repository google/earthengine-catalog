var coll = ee.ImageCollection('FAO/SOFO/1/TPP');
var image = coll.first().select('TPP_1km');
Map.setCenter(17.5, 20, 3);
Map.addLayer(
    image, {min: 0, max: 12, palette: ['blue', 'yellow', 'red']},
    'Tree proximate people – 1km cutoff distance');
