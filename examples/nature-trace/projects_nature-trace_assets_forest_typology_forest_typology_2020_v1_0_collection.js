var dataset =
    ee.ImageCollection(
          'projects/nature-trace/assets/forest_typology/forest_typology_2020_v1_0_collection')
        .mosaic();

// Compute argmax class: 1=Primary, 2=Naturally Regenerating,
// 3=Planted, 4=Plantation, 5=Tree Crops & Agroforestry, 6=Other land.
var b5 = ee.Image(250).subtract(dataset.select([0, 1, 2, 3, 4]).reduce('sum'));
var classified =
    dataset.addBands(b5).toArray().arrayArgmax().arrayGet([0]).add(1);

// Palette: Primary=dark green, Naturally Regenerating=light green,
// Planted=blue, Plantation=pink, TreeCrops=orange, Other=yellow.
var colors = ['1B7837', '7FBF7B', '1D91C0', 'E65FA9', 'E6AB02', 'FDE278'];

Map.addLayer(
    classified, {min: 1, max: 6, palette: colors}, 'Forest Typology 2020 (v1)');

Map.setOptions('HYBRID');
Map.setCenter(116.21, -33.31, 12);
