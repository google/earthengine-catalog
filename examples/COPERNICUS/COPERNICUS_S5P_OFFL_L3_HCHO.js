var collection = ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_HCHO')
  .select('tropospheric_HCHO_column_number_density')
  .filterDate('2019-06-01', '2019-06-06');

var band_viz = {
  min: 0.0,
  max: 0.0003,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'S5P HCHO');
Map.setCenter(0.0, 0.0, 2);
