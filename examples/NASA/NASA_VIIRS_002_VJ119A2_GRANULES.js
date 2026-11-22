var collection = ee.ImageCollection('NASA/VIIRS/002/VJ119A2_GRANULES')
                     .select('Optical_Depth_047')
                     .filterDate('2018-01-05', '2018-01-10');

var band_viz = {
  min: 0,
  max: 500,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'Optical Depth 047');
Map.setCenter(76, 13, 6);
