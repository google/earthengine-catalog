var dataset = ee.FeatureCollection('LARSE/GEDI/GEDI02_A_002/GEDI02_A_2021244154857_O15413_04_T05622_02_003_02_V002');
dataset = dataset.style({color: 'black',  pointSize: 1});
Map.setCenter(-64.88, -31.77, 15);
Map.addLayer(dataset);
