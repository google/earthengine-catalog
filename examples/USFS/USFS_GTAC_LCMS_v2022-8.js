var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2022-8');

var lcms = dataset
    .filter(ee.Filter.and(
      ee.Filter.eq('year', 2022),  // range: [1985, 2022]
      ee.Filter.eq('study_area', 'CONUS')  // or 'SEAK'
    ))
    .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Thematic Change', false);

Map.setCenter(-98.58, 38.14, 4);
