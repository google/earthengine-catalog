var dataset = ee.Image('Germany/Brandenburg/20cm');
Map.setCenter(13.386091, 52.507899, 18);
Map.addLayer(dataset, null, 'Brandenburg 20cm');
