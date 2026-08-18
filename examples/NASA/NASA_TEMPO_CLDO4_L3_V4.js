var collection = ee.ImageCollection('NASA/TEMPO/CLDO4_L3_V4')
    .filterDate('2024-04-01', '2024-04-05')

var visParams = {
  min: 0,
  max: 1,
  bands: ['cloud_fraction'],
};
Map.setCenter(-95.06, 42.02, 3)
Map.addLayer(collection, visParams, 'Cloud Fraction')
