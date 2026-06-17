var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2024-10');

var lcms = dataset.filterDate('2022', '2023')  // range: [1985, 2024]
               .filter('study_area == "CONUS"')  // "AK", "HAWAII", "PRUSVI" 
               .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Vegetation Change', false);

Map.setCenter(-98.58, 38.14, 4);
