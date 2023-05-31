var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2020-6');

// range: [1985, 2021]
var lcms = dataset.filterDate('2020-06-01')
    .filter('study_area == "PRUSVI"')  // Puero Rico only in this version.
    .first();

Map.addLayer(lcms.select('Land_Cover'), {}, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), {}, 'Land Use');
Map.addLayer(lcms.select('Change'), {}, 'Vegetation Change');

Map.setCenter(-66.4239, 18.1384, 9);
