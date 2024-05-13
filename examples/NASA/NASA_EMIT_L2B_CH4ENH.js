var dataset = ee.ImageCollection('NASA/EMIT/L2B/CH4ENH');
var emitEnhancement = dataset.select('vertical_column_enhancement');
var emitEnhancementVis = {
  min: 0,
  max: 100.0,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};
Map.setCenter(-100.24, 32.04, 5);
Map.addLayer(
    emitEnhancement, emitEnhancementVis,
    'Emit Enhancement');