var dataset = ee.Image('UMN/PGC/ArcticDEM/V4/2m_mosaic');

var elevationVis = {
  min: -50.0,
  max: 1000.0,
  palette: ['0d13d8', '60e1ff', 'ffffff'],
  bands: ['elevation'],
};

var countVis = {
  min: 0,
  max: 10,
  palette: [
    'black',
    'blue',
    'purple',
    'cyan',
    'green',
    'yellow',
    'red',
  ],
  bands: ['count'],
};

var madVis = {
  min: 0,
  max: 50,
  palette: [
    '006633',
    'E69800',
    'D4E157',
    'FFF59D',
  ],
  bands: ['mad'],
};

var datamaskVis = {
  min: 0,
  max: 1,
  palette: [
    'black',
    'white',
  ],
  bands: ['datamask'],
};

Map.setCenter(-63.402, 66.368, 7);

Map.addLayer(dataset, elevationVis, 'Elevation', true);
Map.addLayer(dataset, countVis, 'Data Count', false);
Map.addLayer(dataset, madVis, 'MAD', false);
Map.addLayer(dataset, datamaskVis, 'Data Mask', false);
