var collection = ee.ImageCollection("AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1");

// Visualize a SPOT 5 scene with NIR, Red, Green
var image = collection.filter(ee.Filter.eq('satellite', 'SPOT5')).first();
Map.centerObject(image, 13);
Map.addLayer(image, {bands: ['B3', 'B2', 'B1'], min: 0, max: 200}, 'Multispectral False Color');
