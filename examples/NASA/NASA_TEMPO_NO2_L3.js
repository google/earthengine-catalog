var collection = ee.ImageCollection('NASA/TEMPO/NO2_L3')
    .filterDate('2024-04-01', '2024-04-05')

var visParams = {
  min: 0,
  max: 1.5e16,
  bands: ['vertical_column_troposphere'],
  palette: [
    '000080', '0000D9', '4000FF', '8000FF', '0080FF',
    '00D9FF', '80FFFF', 'FF8080', 'D90000', '800000'
  ]
};
Map.setCenter(-95.06, 42.02, 3)
Map.addLayer(collection, visParams, 'Tropospheric NO2')
