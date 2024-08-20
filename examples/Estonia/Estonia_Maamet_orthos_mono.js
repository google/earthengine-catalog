var dataset = ee.ImageCollection('Estonia/Maamet/orthos/mono');
Map.setCenter(26.61312, 58.5879, 15);
Map.addLayer(dataset, null, 'Estonia Maamet mono');
