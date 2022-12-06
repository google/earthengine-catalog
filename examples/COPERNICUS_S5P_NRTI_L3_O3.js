var collection = ee.ImageCollection('COPERNICUS/S5P/NRTI/L3_O3')
  .select('O3_column_number_density')
  .filterDate('2019-06-01', '2019-06-05');

var band_viz = {
  min: 0.12,
  max: 0.15,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'S5P O3');
Map.setCenter(0.0, 0.0, 2);
