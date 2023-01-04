var dataset = ee.ImageCollection('Finland/SMK/VV/50cm');

Map.setCenter(25.7416, 62.2446, 16);
Map.addLayer(dataset, null, 'Finland 50 cm(false color)');
