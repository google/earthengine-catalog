var dataset = ee.ImageCollection('Estonia/Maamet/orthos/mono');
Map.setCenter(24.959, 58.148, 15);
Map.addLayer(dataset, null, 'Estonia Maamet mono');
