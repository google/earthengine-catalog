var collection = ee.ImageCollection('MODIS/061/MCD19A1_GRANULES')
                     .select('Sur_refl1')
                     .filterDate('2000-01-01', '2000-03-07');

var band_viz = {
  min: 0,
  max: 1100,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'Surface Bidirectional Reflectance Factor');
Map.setCenter(76, 13, 6);
