var dataset = ee.ImageCollection('Slovakia/orthos/25cm');

Map.setCenter(19.163, 48.751, 15);
Map.addLayer(dataset, {}, 'Slovakia orthophotos RGB');