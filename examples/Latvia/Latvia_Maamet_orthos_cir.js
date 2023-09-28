var dataset = ee.ImageCollection('Latvia/Maamet/orthos/cir');

Map.setCenter(24.737, 56.861, 15);
Map.addLayer(dataset, null, 'Latvia Maamet Color InfraRed (CIR)');