var lcms = ee.ImageCollection('USFS/GTAC/LCMS/v2022-8').first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Thematic Change', false);

Map.setCenter(-98.58, 38.14, 4);
