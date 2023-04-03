var dataset = ee.Image('ORTHO/Switzerland/SWISSIMAGE/10cm/2017');

Map.setCenter(7.75, 46.02, 18);
Map.addLayer(dataset, null, 'Switzerland 10 cm');
