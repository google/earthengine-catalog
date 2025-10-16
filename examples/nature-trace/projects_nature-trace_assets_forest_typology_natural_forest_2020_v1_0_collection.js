var probabilities =
    ee.ImageCollection(
          'projects/nature-trace/assets/forest_typology/natural_forest_2020_v1_0_collection')
        .mosaic()
        .select('B0');

Map.addLayer(
    probabilities.mask(probabilities.neq(0)),
    {min: 0, max: 250, palette: ['white', 'green']},
    'Natural forest probabilities');

Map.addLayer(
    probabilities.gte(0.5).mask(probabilities.gte(0.5)), {palette: 'teal'},
    'Natural forest map at threshold');