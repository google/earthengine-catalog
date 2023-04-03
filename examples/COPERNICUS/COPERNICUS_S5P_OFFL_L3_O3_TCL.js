var collection = ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_O3_TCL')
  .select('ozone_tropospheric_vertical_column')
  .filterDate('2019-06-01', '2019-07-01');

var band_viz = {
  min: 0,
  max: 0.02,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'S5P O3');
Map.setCenter(0.0, 0.0, 2);
