var dataset = ee.Image('OpenLandMap/SOL/SOL_SAND-WFRACTION_USDA-3A1A1A_M/v02');

var visualization = {
  bands: ['b0'],
  min: 1.0,
  max: 100.0,
  palette: [
    'ffff00', 'f8f806', 'f1f10c', 'ebeb13', 'e4e419', 'dddd20',
    'd7d726', 'd0d02d', 'caca33', 'c3c33a', 'bcbc41', 'b6b647',
    'b0b04e', 'a9a954', 'a3a35a', '9c9c61', '959568', '8f8f6e',
    '898975', '82827b', '7b7b82', '757589', '6e6e8f', '686895',
    '61619c', '5a5aa3', '5454a9', '4d4db0', '4747b6', '4141bc',
    '3a3ac3', '3333ca', '2d2dd0', '2626d7', '2020dd', '1919e4',
    '1212eb', '0c0cf1', '0606f8', '0000ff',
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'Sand content in % (kg / kg)');
