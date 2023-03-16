var collection = ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_AER_AI')
  .select('absorbing_aerosol_index')
  .filterDate('2019-06-01', '2019-06-06');

var band_viz = {
  min: -1,
  max: 2.0,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'S5P Aerosol');
Map.setCenter(-118.82, 36.1, 5);
