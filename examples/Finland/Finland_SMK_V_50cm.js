var dataset = ee.ImageCollection('Finland/SMK/V/50cm');

Map.setCenter(24.9, 60.2, 17);
Map.addLayer(dataset, null, 'Finland 50 cm(color)');
