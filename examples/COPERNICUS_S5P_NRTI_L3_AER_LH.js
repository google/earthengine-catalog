var collection = ee.ImageCollection('COPERNICUS/S5P/NRTI/L3_AER_LH')
  .select('aerosol_height')
  .filterDate('2019-06-01', '2019-06-06');

var band_viz = {
  min: -81.17,
  max: 67622.56,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'S5P Aerosol Height');
Map.setCenter(44.09, 24.27, 4);
