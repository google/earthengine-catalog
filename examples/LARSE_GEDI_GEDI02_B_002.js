var dataset = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_B_002/GEDI02_B_2021043114136_O12295_03_T07619_02_003_01_V002');
Map.setCenter(12.60033, 51.01051, 14);
Map.addLayer(dataset);
