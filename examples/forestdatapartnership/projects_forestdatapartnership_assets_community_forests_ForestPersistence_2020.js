Map.setCenter(-123.296, 43.8246, 12);

var forestPersistence = ee.Image(
    'projects/forestdatapartnership/assets/community_forests/ForestPersistence_2020');

Map.addLayer(forestPersistence, {}, 'ForestPersistence');
Map.addLayer(
    forestPersistence.gt(0.95).selfMask(), {palette: 'green'},
    'Persistent forest');