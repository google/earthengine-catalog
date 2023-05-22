var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP43IA1')
                .filter(ee.Filter.date('2017-03-10', '2017-03-11'));

var visualization = {
  bands: ['BRDF_Albedo_Parameters_fiso_I1'],
  min: 0,
  max: 1,
  palette: [
    '000080','0000d9','4000ff','8000ff','0080ff','00ffff',
    '00ff80','80ff00','daff00','ffff00','fff500','FFda00',
    'ffb000','ffa400','ff4f00','ff2500','ff0a00','ff00ff',
  ]
};

Map.setCenter(89, 58, 3);

Map.addLayer(dataset, visualization, 'isotropic parameter for band I1');