
var fc = ee.FeatureCollection('GOOGLE/AirView/California_Unified_2015_2019');

var normal = fc.filter('NO2 >= 0 && NO2 < 1');
var mild = fc.filter('NO2 >= 1 && NO2 < 2');
var strong = fc.filter('NO2 >= 2');

Map.addLayer(normal, {color: 'green'}, 'NO2 [0; 1)');
Map.addLayer(mild, {color: 'yellow'}, 'NO2 [1; 2)');
Map.addLayer(strong, {color: 'red'}, 'NO2 >= 2');
Map.setCenter(-122.827746, 38.4001353, 20);
Map.setOptions('SATELLITE');
