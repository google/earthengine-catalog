var collection = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PMS_NC/V1');

var image = collection.filter(ee.Filter.eq('satellite', 'SPOT5')).first();

// Apply Google cloud mask band to the image.
image = image.updateMask(image.select('cloud_mask'));

Map.centerObject(image, 13);
Map.addLayer(image, {bands: ['R', 'G', 'B'], min: 0, max: 200}, 'Pansharpened RGB');
