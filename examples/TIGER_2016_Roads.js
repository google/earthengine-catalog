var dataset = ee.FeatureCollection('TIGER/2016/Roads');
var roads = dataset.style({color: '#4285F4', width: 1});
Map.setCenter(-73.99172, 40.74101, 12);
Map.addLayer(roads, {}, 'TIGER/2016/Roads');
