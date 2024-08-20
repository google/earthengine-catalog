var dataset = ee.ImageCollection('Estonia/Maamet/orthos/rgb_low_flying');
Map.setCenter(24.959, 58.148, 18);
Map.addLayer(dataset, null, 'Estonia Maamet rgb low flying');
