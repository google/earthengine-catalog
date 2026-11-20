var dataset = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_B_003/' +
    'GEDI02_B_2021043114136_O12295_03_T07619_02_004_01_V003');
var styled = dataset.style({color: 'black', pointSize: 1});

Map.setCenter(12.60033, 51.01051, 13);
Map.addLayer(styled, {}, 'GEDI L2B V003');
