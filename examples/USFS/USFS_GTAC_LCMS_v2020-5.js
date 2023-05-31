var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2020-5');

var lcms = dataset.filterDate('2020', '2021')  // range: [1985, 2020]
               .filter('study_area == "CONUS"')  // or "SEAK"
               .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Vegetation Change', false);

Map.setCenter(-98.58, 38.14, 4);
