var l4b = ee.Image('LARSE/GEDI/GEDI04_B_002')

Map.addLayer(
    l4b.select('MU'),
    {min: 10, max: 250, palette: '440154,414387,2a788e,23a884,7ad151,fde725'},
    'Mean Biomass');
Map.addLayer(
    l4b.select('SE'),
    {min: 10, max: 50, palette: '000004,3b0f6f,8c2981,dd4a69,fe9f6d,fcfdbf'},
    'Standard Error');
