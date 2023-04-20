var dataset = ee.ImageCollection('TERN/AET/CMRSET_LANDSAT_V2_2');

var visualization = {
  bands: ['ETa'],
  min: 0,
  max: 7,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6']
};

Map.setCenter(132, -27, 4);

Map.addLayer(dataset, visualization, 'Average daily evapotranspiration');
