var dataset = ee.ImageCollection('Netherlands/Beeldmateriaal/LUCHTFOTO_RGB');

Map.setCenter(5.54, 51.88, 15);
Map.addLayer(dataset, {}, 'Netherlands orthophotos RGB');