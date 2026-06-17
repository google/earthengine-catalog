// To access this dataset, fill out the form: https://forms.gle/jQmCbWgarjENQBYz6

var collection = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS_NC/V1')
  .filterBounds(ee.Geometry.Point(-45.2, -19.5));

var image = collection.first();
// Apply Google cloud mask band to image.
image = image.updateMask(image.select('cloud_mask'));

Map.centerObject(image, 12);
Map.addLayer(image, {bands: ['R', 'G', 'B'], min: 0, max: 255}, 'RGB');
