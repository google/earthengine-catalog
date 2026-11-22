var collection = ee.ImageCollection('NASA/VIIRS/002/VNP19A2_GRANULES')
                     .select('Optical_Depth_047')
                     .filterDate('2012-01-19', '2012-01-24');

var band_viz = {
  min: 0,
  max: 500,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.addLayer(collection.mean(), band_viz, 'Optical Depth 047');
Map.setCenter(76, 13, 6);
