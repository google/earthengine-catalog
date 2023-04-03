var dataset = ee.ImageCollection('Spain/PNOA/PNOA10');
Map.setCenter(-1.859852, 38.983734, 19);
Map.addLayer(dataset, null, 'Spain 10cm');