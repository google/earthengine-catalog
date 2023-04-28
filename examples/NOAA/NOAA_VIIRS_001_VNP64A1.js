var image = ee.Image('NOAA/VIIRS/001/VNP64A1/2018_12_01');
var visualization = {
  bands: ['Last_Day'],
  min: 250.0,
  max: 320.0,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
};

Map.setCenter(-119.13, 38.32, 8);
Map.addLayer(image, visualization, 'Last day');
