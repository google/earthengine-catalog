var dataset = ee.ImageCollection('CSP/HM/GlobalHumanModification');

var visualization = {
  bands: ['gHM'],
  min: 0.0,
  max: 1.0,
  palette: ['0c0c0c', '071aff', 'ff0000', 'ffbd03', 'fbff05', 'fffdfd']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'Human modification');
