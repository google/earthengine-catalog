var dataset = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_A_003/' +
    'GEDI02_A_2021244154857_O15413_04_T05622_02_004_02_V003');
var styled = dataset.style({color: 'black', pointSize: 1});

Map.setCenter(-64.88, -31.77, 13);
Map.addLayer(styled, {}, 'GEDI L2A V003');
