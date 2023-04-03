var collection = ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_AER_LH')
                    .select('aerosol_height')
                    .filterDate('2019-06-01', '2019-06-05');

var visualization = {
  min: 0,
  max: 6000,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

Map.setCenter(44.09, 24.27, 4);

Map.addLayer(collection.mean(), visualization, 'S5P Aerosol Height');
