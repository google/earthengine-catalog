var dataset = ee.Image('Switzerland/SWISSIMAGE/orthos/10cm/2017');

Map.setCenter(7.75, 46.02, 18);
Map.addLayer(dataset, null, 'Switzerland RGB (10 cm)');
