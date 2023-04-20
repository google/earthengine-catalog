var dataset = ee.FeatureCollection(
  'LARSE/GEDI/GEDI04_A_002/GEDI04_A_2022157233128_O19728_03_T11129_02_003_01_V002');
Map.setCenter(-94.77616, 38.9587, 14);
Map.addLayer(dataset);
