var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2023-9');

var lcms = dataset.filterDate('2021', '2022')  // range: [1985, 2023]
               .filter('study_area == "CONUS"')  // or "SEAK" ("PRUSVI" and "HAWAII" available late summer 2024)
               .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Vegetation Change', false);

Map.setCenter(-98.58, 38.14, 4);
