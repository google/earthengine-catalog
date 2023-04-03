var collection = ee.ImageCollection('MODIS/006/MCD19A2_GRANULES')
                  .select('Optical_Depth_047')
                  .filterDate('2019-01-01', '2019-01-15');

var band_viz = {
  min: 0,
  max: 500,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'Optical Depth 047');
Map.setCenter(76, 13, 6);
