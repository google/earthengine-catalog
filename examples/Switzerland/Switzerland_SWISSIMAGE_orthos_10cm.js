var dataset = ee.Image('Switzerland/SWISSIMAGE/orthos/10cm');

Map.setCenter(7.75, 46.02, 18);
Map.addLayer(dataset, null, 'Switzerland 10 cm');
