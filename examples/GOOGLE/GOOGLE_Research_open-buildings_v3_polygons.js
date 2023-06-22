// Visualization of GOOGLE/Research/open-buildings/v3/polygons.

var t = ee.FeatureCollection('GOOGLE/Research/open-buildings/v3/polygons');

var t_065_070 = t.filter('confidence >= 0.65 && confidence < 0.7');
var t_070_075 = t.filter('confidence >= 0.7 && confidence < 0.75');
var t_gte_075 = t.filter('confidence >= 0.75');

Map.addLayer(t_065_070, {color: 'FF0000'}, 'Buildings confidence [0.65; 0.7)');
Map.addLayer(t_070_075, {color: 'FFFF00'}, 'Buildings confidence [0.7; 0.75)');
Map.addLayer(t_gte_075, {color: '00FF00'}, 'Buildings confidence >= 0.75');
Map.setCenter(3.389, 6.492, 17);  // Lagos, Nigeria
Map.setOptions('SATELLITE');
