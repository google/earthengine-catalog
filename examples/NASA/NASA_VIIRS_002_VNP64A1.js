var image = ee.Image('NASA/VIIRS/002/VNP64A1/2025_01_01');

var visualization = {
  bands: ['Burn_Date'],
  min: 0,
  max: 31,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
};

Map.setCenter(-118.24, 34.06, 10);
Map.addLayer(image, visualization, 'Burn Date');