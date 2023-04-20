var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2020-5');

var lcms = dataset
    .filter(ee.Filter.and(
      ee.Filter.eq('year', 2020),  // range: [1985, 2020]
      ee.Filter.eq('study_area', 'CONUS')  // or 'SEAK'
    ))
    .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Change');

Map.setCenter(-98.58, 38.14, 4);
