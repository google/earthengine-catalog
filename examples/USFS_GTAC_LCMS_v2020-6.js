var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2020-6');

var lcms = dataset
    .filter(ee.Filter.and(
      ee.Filter.eq('year', 2020),  // range: [1985, 2021]
      ee.Filter.eq('study_area', 'PRUSVI')  // Puero Rico only in this version.
    ))
    .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Change');

Map.setCenter(-66.4239, 18.1384, 9);
