// Visualization of GOOGLE/Research/open-buildings/v1/polygons.

var t = ee.FeatureCollection('GOOGLE/Research/open-buildings/v1/polygons');

var t_060_065 = t.filter('confidence >= 0.60 && confidence < 0.65');
var t_065_070 = t.filter('confidence >= 0.65 && confidence < 0.70');
var t_gte_070 = t.filter('confidence >= 0.70');

Map.addLayer(t_060_065, {color: 'FF0000'}, 'Buildings confidence [0.60; 0.65)');
Map.addLayer(t_065_070, {color: 'FFFF00'}, 'Buildings confidence [0.65; 0.70)');
Map.addLayer(t_gte_070, {color: '00FF00'}, 'Buildings confidence >= 0.70');
Map.setCenter(3.389, 6.492, 17);  // Lagos, Nigeria
Map.setOptions('SATELLITE');
