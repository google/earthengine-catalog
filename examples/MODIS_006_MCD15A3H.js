var dataset = ee.ImageCollection('MODIS/006/MCD15A3H');
var defaultVisualization = dataset.first().select('Fpar');
var defaultVisualizationVis = {
  min: 0.0,
  max: 100.0,
  palette: ['e1e4b4', '999d60', '2ec409', '0a4b06'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(
    defaultVisualization, defaultVisualizationVis, 'Default visualization');
