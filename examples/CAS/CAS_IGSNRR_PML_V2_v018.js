var dataset = ee.ImageCollection('CAS/IGSNRR/PML/V2_v018');

var visualization = {
  bands: ['GPP'],
  min: 0.0,
  max: 9.0,
  palette: [
    'a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf',
    'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837',
  ]
};

Map.setCenter(0.0, 15.0, 2);

Map.addLayer(
    dataset.first(), visualization, 'PML_V2 0.1.8 Gross Primary Product (GPP)');
