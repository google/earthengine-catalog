var dataset = ee.ImageCollection('Estonia/Maamet/orthos/rgb');
Map.setCenter(24.959, 58.148, 18);
Map.addLayer(dataset, null, 'Estonia Maamet rgb');
