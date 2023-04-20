var collection = ee.ImageCollection('JAXA/ALOS/PALSAR-2/Level2_2/ScanSAR')
  .filterBounds(ee.Geometry.Point(143, -5));
var image = collection.first();

Map.addLayer(image.select(['HH']), {min: 0, max: 8000}, 'HH polarization');
Map.centerObject(image);
