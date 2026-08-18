var dataset = ee.ImageCollection('TNC/HM/v3/90m_s');

var visualization = {
  bands: ['All_threats_combined'],
  min: 0.0,
  max: 1.0,
  palette: ['0c0c0c', '071aff', 'ff0000', 'ffbd03', 'fbff05', 'fffdfd']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'TNC Global Human Modification v3 (Static Snapshot 90m)');
