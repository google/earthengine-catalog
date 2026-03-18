var collection = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS_NC/V1')
  .filterBounds(ee.Geometry.Point(-45.2603, -19.5429));

var image = collection.first();
// Apply Google cloud mask band to image.
image = image.updateMask(image.select('cloud_mask'));

Map.centerObject(image, 12);
Map.addLayer(image, {bands: ['R', 'G', 'B'], min: 0, max: 255}, 'RGB');
