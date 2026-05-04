var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LCMS/Product_Version/2025-11');

var lcms = dataset.filterDate('2023', '2024')  // range: [1985, 2025]
               .filter('study_area == "CONUS"')  // "AK" 
               .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Vegetation Change', false);

Map.setCenter(-98.58, 38.14, 4);
