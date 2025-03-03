var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP43IA4')
                  .filter(ee.Filter.date('2021-06-01', '2021-06-03'));

var visualization = {
  bands: ['BRDF_Albedo_Band_Mandatory_Quality_I1'],
  min: 0,
  max: 1,
  palette: [
    '000080',
    '0000d9',
    '4000ff',
    '8000ff',
    '0080ff',
    '00ffff',
    '00ff80',
    '80ff00',
    'daff00',
    'ffff00',
    'fff500',
    'ffda00',
    'ffb000',
    'ffa400',
    'ff4f00',
    'ff2500',
    'ff0a00',
    'ff00ff',
  ]
};

Map.setCenter(80, 66, 6);

Map.addLayer(
    dataset, visualization, 'BRDF/Albedo mandatory quality for band I1');