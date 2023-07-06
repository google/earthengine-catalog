var aez = ee.FeatureCollection('ESA/WorldCereal/AEZ/v100');

// Find the AEZs with multiple growing seasons for maize and cereal.
var twoMaizeAez =
    aez.filter(ee.Filter.notNull(['tc-maize-main_eos', 'tc-maize-second_eos']));
var twoCerealAez = aez.filter(
    ee.Filter.notNull(['tc-wintercereals_eos', 'tc-springcereals_eos']));

Map.addLayer(
    twoMaizeAez.draw('ff0000', 1, 2), {}, 'AEZ with two maize seasons');
Map.addLayer(
    twoCerealAez.draw('0000ff', 1, 2), {}, 'AEZ with two cereal seasons');
