var dataset = ee.Image('IAHS/GFPLAIN250/v0');
Map.setCenter(31.25, 30.05, 7);
Map.addLayer(dataset);
