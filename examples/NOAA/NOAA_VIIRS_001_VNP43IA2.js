var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP43IA2')
                .filter(ee.Filter.date('2021-06-01', '2021-06-03'));

var visualization = {
  bands: ['BRDF_Albedo_ValidObs_I1'],
  min: 35550,
  max: 45535,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
};

Map.setCenter(89, 58, 6);

Map.addLayer(dataset, visualization, 'Days of valid observation for band I1');
