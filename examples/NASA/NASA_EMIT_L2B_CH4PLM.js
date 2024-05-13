var dataset = ee.ImageCollection('NASA/EMIT/L2B/CH4PLM');
var emitEnhancement = dataset.select('methane_plume_complex');
var emitEnhancementVis = {
  min: 0,
  max: 100.0,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};
Map.setCenter(53.99, 39.11, 8);
Map.addLayer(
    emitEnhancement, emitEnhancementVis,
    'Emit Enhancement');
